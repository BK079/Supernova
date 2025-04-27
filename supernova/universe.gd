extends Node2D

var masstrack : float
var heatrack : float
@export var gravityrange : float
@export var solarsystem : PackedScene

func _ready():
	masstrack = $PlayerStar.mass
	heatrack = $PlayerStar.heat
	$Camera2D/Control/GUI/VBoxContainer2/HBoxContainer2/MassBar.value = masstrack
	$Camera2D/Control/GUI/VBoxContainer2/HBoxContainer/HeatBar.value = heatrack
	var systeminstance = solarsystem.instantiate()
	print(get_child(0).get_global_position())
	add_child(systeminstance)
	

	
	
func _physics_process(_delta):
	if Input.is_action_pressed("Onmouseleft") and has_node("PlayerStar"):
		masstrack = $PlayerStar.mass
		$Camera2D/Control/GUI/VBoxContainer2/HBoxContainer2/MassBar.value = masstrack
	if Input.is_action_pressed("Onmouseright") and has_node("PlayerStar"):
		heatrack = $PlayerStar.heat
		$Camera2D/Control/GUI/VBoxContainer2/HBoxContainer/HeatBar.value = heatrack
	if !Globals.celestialbodies.is_empty() and has_node("PlayerStar"):
		for bodies in Globals.celestialbodies:
			if is_instance_valid(bodies):
				var distance = $PlayerStar.get_global_position() - bodies.get_global_position()
				if  distance.length() < $PlayerStar.mass*gravityrange:
					bodies.stableorbit = false
				
	$Camera2D.mass = masstrack

func _on_player_star_absorbed(body):
	$PlayerStar/Cameratransform.reparent(body)
	$SunEatsYou.play()


func _on_player_star_massheatupdate(mass, heat):
	masstrack = mass
	heatrack = heat
	$Camera2D/Control/GUI/VBoxContainer2/HBoxContainer2/MassBar.value = masstrack
	$Camera2D/Control/GUI/VBoxContainer2/HBoxContainer/HeatBar.value = heatrack
	
	
