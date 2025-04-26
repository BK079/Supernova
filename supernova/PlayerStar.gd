extends RigidBody2D

@export var thrust = 20
@export var heat : int
@export var fakemass : int
@export var density : float

signal absorbed

func _onready():
	$CollisionShape2D.shape.radius = max(mass*density, 1)
	$Sprite2D.scale = Vector2(max(mass*density*0.03, 0.01), max(mass*density*0.03, 0.01))

func _on_body_entered(body):
	if body.is_in_group("Planets"):
		print(body.get_rid())
		mass += body.mass
		body.queue_free()
		$EatingPlanet.play()
	if body.is_in_group("Celestials"):
		print(body.get_rid())
		print(body.mass)
		if body.mass > self.mass:
			absorbed.emit(body)
			queue_free()
		if self.mass > body.mass:
			mass += body.mass
			body.queue_free()

func _integrate_forces(state):
	var disttomouse = get_global_mouse_position() - get_global_position()
	if Input.is_action_pressed("Onmouseleft"):
		state.apply_force(disttomouse*thrust)
		mass -= 1.0
		print(mass)
	if Input.is_action_pressed("Onmouseright"):
		state.apply_force(disttomouse*thrust)
		heat -= 1
	$CollisionShape2D.shape.radius = max(mass*density, 1)
	$Sprite2D.scale = Vector2(max(mass*density*0.03, 0.01), max(mass*density*0.03, 0.01))
		
