extends RigidBody2D

var type = randi_range(1, 3)
@export var density : float
@export var initial_velocity := Vector2.ZERO
@export var orbitvelocity : float
var orbitradius = randi_range(100, 2000)
var orbitangle = randf_range(-2*PI, 2*PI)
var impulsetrigger = false
var heat : float


var is_star := false
var stableorbit = true

signal instability



func _ready():
	mass = randi_range(1, 100)
	establishtype()
	$Sprite2D.scale = Vector2(mass*density, mass*density)
	$Collidershape.get_shape().radius *= mass*density
	Globals.celestialbodies.append(self)

	
func _physics_process(delta):
	Gravity(delta)
	
	
func Gravity(_delta):
	if stableorbit == false:
		instability.emit()
		for otherbody in Globals.celestialbodies:
			if otherbody != self:
				var otherbodyMass = otherbody.mass
				var direction = self.get_global_position() - otherbody.get_global_position()
				var distance = direction.length()
				var forceMag = Globals.G * ((mass * otherbodyMass) / (distance * distance))
				var force = direction.normalized() * forceMag
				apply_central_force(-force)
	
				
	if stableorbit == true:
		var M = get_parent().mass
		var direction = self.get_global_position() - get_parent().get_global_position()
		var distance = direction.length()
		orbitvelocity = sqrt((Globals.G * M)/distance)*pow(10, -3)
		orbitangle += orbitvelocity * get_process_delta_time()
		var x_pos = cos(orbitangle)
		var y_pos = sin(orbitangle)
		position.x = orbitradius * x_pos
		position.y = orbitradius * y_pos
	
func establishtype():
	if type == 1:
		print("Solid")
		var rockplanet = load("res://rocktransparent.png")
		$Sprite2D.texture = rockplanet
		$Collidershape.get_shape().radius = 280.0
	if type == 2:
		print("Liquid")
		var earthlike = load("res://Earthliketransparent.png")
		$Sprite2D.texture = earthlike
		$Collidershape.get_shape().radius = 400.0
		heat = mass
	if type == 3:
		print("Gas")
		var gasplanet = load("res://Gastransparent.png")
		$Sprite2D.texture = gasplanet
		$Collidershape.get_shape().radius = 830.0
		heat = mass


func _on_body_entered(body):
	if body.is_in_group("Celestials"):
		Globals.celestialbodies.erase(self)
		self.queue_free()
	if body.is_in_group("Planets"):
		if body.mass < self.mass:
			self.mass += body.mass
			self.heat += body.heat
			Globals.celestialbodies.erase(body)
			body.queue_free()
