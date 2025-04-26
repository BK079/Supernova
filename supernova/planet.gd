extends RigidBody2D

var type = randi_range(1, 3)
@export var density : float
@export var initial_velocity := Vector2.ZERO
@export var orbitvelocity : float
@export var orbitradius : float

var orbitangle := 0.0
var is_star := false
var stableorbit = true

signal instability



func _ready():
	establishtype()
	$Collidershape.shape.radius = max(mass*density, 1)
	$Sprite2D.scale = Vector2(max(mass*density*0.015, 0.01), max(mass*density*0.015, 0.01))
	Globals.celestialbodies.append(self)
	pass
	
func _physics_process(delta):
	Gravity(delta)
	
func Gravity(delta):
	if stableorbit == false:
		instability.emit()
		for otherbody in Globals.celestialbodies:
			if otherbody != self:
				var otherbodyMass = otherbody.mass
				var direction = self.get_global_position() - otherbody.get_global_position()
				var distance = direction.length()
				
				var forceMag = Globals.G * ((mass * otherbodyMass) / (distance * distance))
				var force = direction.normalized() * forceMag
				apply_central_force(-force)
				
	if stableorbit == true:
		var M = get_parent().mass
		var direction = self.get_global_position() - get_parent().get_global_position()
		var distance = direction.length()
		orbitvelocity = sqrt((Globals.G * M)/distance)*pow(10, -3)
		orbitangle += orbitvelocity * get_process_delta_time()
		var x_pos = cos(orbitangle)
		var y_pos = sin(orbitangle)
		position.x = orbitradius * x_pos
		position.y = orbitradius * y_pos
	
func establishtype():
	if type == 1:
		print("Solid")
	if type == 2:
		print("Liquid")
	if type == 3:
		print("Gas")
