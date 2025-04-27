extends RigidBody2D

var type = randi_range(1, 3)
@export var density : float
@export var initial_velocity := Vector2.ZERO
@export var orbitvelocity : float
var orbitradius = randi_range(100.0, 2000.0)
var orbitangle = randf_range(-2*PI, 2*PI)
var impulsetrigger = false
var heat : float


var is_star := false
var stableorbit = false

signal instability



func _ready():
	mass = randi_range(10, 100)
	establishtype()
	$Collidershape.shape.radius = max(mass*density, 1)
	$Sprite2D.scale = Vector2(max(mass*density*0.015, 0.01), max(mass*density*0.015, 0.01))
	Globals.celestialbodies.append(self)
	pass
	
func _physics_process(delta):
	Gravity(delta)
	
func Gravity(_delta):
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


func _on_body_entered(body):
	print("test")
	if body.is_in_group("Celestials"):
		Globals.celestialbodies.erase(self)
		self.queue_free()
	if body.is_in_group("Planets"):
		print("test1")
		if body.mass < self.mass:
			print("test2")
			self.mass += body.mass
			self.heat += body.heat
			Globals.celestialbodies.erase(body)
			body.queue_free()
