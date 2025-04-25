extends RigidBody2D

@export var density : float

func _ready():
	$CollisionShape2D.shape.radius = max(mass*density, 1)
	$Sprite2D.scale = Vector2(max(mass*density*0.015, 0.01), max(mass*density*0.015, 0.01))
	pass
