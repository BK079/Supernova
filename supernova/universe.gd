extends Node2D

var masstrack : float
var heatrack : float
@export var gravityrange : float
@export var solarsystem : PackedScene
var sysrange : Array
var losscon3 = false
var losscon4 = false



func sysspawn():
	var syscount = 50
	for i in syscount:
		var systeminstance = solarsystem.instantiate()
		add_child(systeminstance)
		var range = randi_range(1000.0, 40000.0)
		sysrange.append(range)
		get_child(i+6).position = Vector2(range, range).rotated(randf_range(-2*PI, 2*PI))
		
		

func _ready():
	masstrack = $PlayerStar.mass
	heatrack = $PlayerStar.heat
	$Camera2D/Control/GUI/VBoxContainer2/HBoxContainer2/MassBar.value = masstrack
	$Camera2D/Control/GUI/VBoxContainer2/HBoxContainer/HeatBar.value = heatrack
	var systeminstance = solarsystem.instantiate()
	add_child(systeminstance)
	sysspawn()
	

	
	
func _physics_process(_delta):
	if Input.is_action_just_released("quit"):
		get_tree().quit()
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
	if Input.is_action_just_released("resetkey"):
		player_reset_universe()
	$Camera2D.mass = masstrack
	if masstrack >= 1000:
		get_tree().quit()
	if heatrack >= 1000:
		get_tree().quit()
	if masstrack <= 50:
		get_tree().quit()
	if heatrack <= 50:
		get_tree().quit()

func _on_player_star_absorbed(body):
	$PlayerStar/Cameratransform.reparent(body)
	$SunEatsYou.play()


func player_reset_universe():
	for bodies in Globals.celestialbodies:
		if is_in_group("Celestials") and is_instance_valid(bodies):
				var distance = $PlayerStar.get_global_position() - bodies.get_global_position()
				if  distance.length() > 10000:
					print("reset!")
					$PlayerStar.freeze = true
					$PlayerStar.global_position = Vector2(0, 0)
					sysspawn()
					$PlayerStar.freeze = false
		


func _on_player_star_massheatupdate(mass, heat):
	masstrack = mass
	heatrack = heat
	$Camera2D/Control/GUI/VBoxContainer2/HBoxContainer2/MassBar.value = masstrack
	$Camera2D/Control/GUI/VBoxContainer2/HBoxContainer/HeatBar.value = heatrack
	
	
func _on_quit_button_pressed():
	get_tree().quit()

func _on_camera_2d_zoomlvl(zoom_current):
	$ParallaxBG.scale = Vector2(1/zoom_current, 1/zoom_current)
