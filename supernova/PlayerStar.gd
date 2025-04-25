extends Node2D
var thrust = 200

@onready var mass = 200
@onready var heat = 200



func _integrate_forces(state):
	var disttomouse = get_global_mouse_position() - get_global_position()
	if Input.is_action_pressed("Onmouseleft"):
		state.apply_force(disttomouse)
		mass -= 1
	if Input.is_action_pressed("Onmouseright"):
		state.apply_force(disttomouse)
		heat -= 1
	print(mass)
	print(heat)
