extends Node2D

var masstrack : float
var heatrack : float



func _ready():
	masstrack = $PlayerStar.mass
	heatrack = $PlayerStar.heat
	$Camera2D/Control/GUI/VBoxContainer2/HBoxContainer2/MassBar.value = masstrack
	$Camera2D/Control/GUI/VBoxContainer2/HBoxContainer/HeatBar.value = heatrack
	
func _physics_process(delta):
	if Input.is_action_pressed("Onmouseleft"):
		masstrack = $PlayerStar.mass
		$Camera2D/Control/GUI/VBoxContainer2/HBoxContainer2/MassBar.value = masstrack
	if Input.is_action_pressed("Onmouseright"):
		heatrack = $PlayerStar.heat
		$Camera2D/Control/GUI/VBoxContainer2/HBoxContainer/HeatBar.value = heatrack

func _on_player_star_absorbed(body):
	$PlayerStar/RemoteTransform2D.reparent(body)


func _on_player_star_massheatupdate(mass, heat):
	masstrack = mass
	print(masstrack)
	heatrack = heat
	print(heatrack)
	$Camera2D/Control/GUI/VBoxContainer2/HBoxContainer2/MassBar.value = masstrack
	$Camera2D/Control/GUI/VBoxContainer2/HBoxContainer/HeatBar.value = heatrack
	
