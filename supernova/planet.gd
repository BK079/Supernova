extends RigidBody2D

var type = randi_range(1, 3)
@export var density : float
@export var G = 6.6743 * pow(10, 4)
@export var initial_velocity := Vector2.ZERO
var is_star := false
var stableorbit = true
signal instability



func _ready():
	establishtype()
	$CollisionShape2D.shape.radius = max(mass*density, 1)
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
				
				var forceMag = G * ((mass * otherbodyMass) / (distance * distance))
				var force = direction.normalized() * forceMag
				apply_central_force(-force)
	if stableorbit == true:
		var centripetal = self.get_global_position() - get_parent().get_node("OtherStar").get_global_position()
		var r = centripetal.length()
		var starmass = get_parent().get_node("OtherStar").mass
		var velocitydir = centripetal.rotated(deg_to_rad(90))
		print(velocitydir)
		var velocity = sqrt((G * starmass)/r)
		var force = velocitydir.normalized() * velocity*10
		apply_central_force(force)
	
	
func establishtype():
	if type == 1:
		print("Solid")
	if type == 2:
		print("Liquid")
	if type == 3:
		print("Gas")
