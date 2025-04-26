extends RigidBody2D

@export var thrust = 20
@export var heat : float
@export var density : float


signal absorbed
signal massheatupdate

func _onready():
	$CollisionShape2D.shape.radius = max(mass*density, 1)
	$Sprite2D.scale = Vector2(max(mass*density, 0.01), max(mass*density, 0.01))


func _on_body_entered(body):
	if body.is_in_group("Planets"):
		if body.type == 1:
			mass += body.mass
		if body.type == 2:
			mass += body.mass*0.5
			heat += body.mass*0.5
		if body.type == 3:
			heat += body.mass
		body.queue_free()
	if body.is_in_group("Celestials"):
		print(body.get_rid())
		print(body.mass)
		if body.mass > self.mass:
			absorbed.emit(body)
			queue_free()
		if self.mass > body.mass:
			mass += body.mass
			heat += body.mass
			body.queue_free()
	massheatupdate.emit(mass, heat)

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
		
