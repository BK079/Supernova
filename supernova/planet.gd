extends RigidBody2D

var type = randi_range(1, 3)
@export var density : float

func _ready():
	establishtype()
	$CollisionShape2D.shape.radius = max(mass*density, 1)
	$Sprite2D.scale = Vector2(max(mass*density*0.015, 0.01), max(mass*density*0.015, 0.01))
	pass
	
func establishtype():
	if type == 1:
		print("Solid")
	if type == 2:
		print("Liquid")
	if type == 3:
		print("Gas")
