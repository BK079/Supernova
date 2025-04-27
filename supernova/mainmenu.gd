extends Node2D

@export var universescene : PackedScene

func _physics_process(delta):
	if Input.is_action_just_released("StartGame"):
		var universe = universescene.instantiate()
		add_child(universe)
		$Sprite2D.hide()
	
func _on_quit_button_pressed():
	if Input.is_action_just_released("quit"):
		get_tree().quit()
	
