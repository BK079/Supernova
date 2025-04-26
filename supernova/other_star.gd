extends RigidBody2D

@export var density : float
@export var G = 6.6743 * pow(10, 4)
@export var initial_velocity := Vector2.ZERO
var is_star := true
var stableorbit := true
var orbitdict : Dictionary


func _ready():
	$CollisionShape2D.shape.radius = max(mass*density, 1)
	$Sprite2D.scale = Vector2(max(mass*density*0.015, 0.01), max(mass*density*0.015, 0.01))
	linear_velocity = initial_velocity
	Globals.celestialbodies.append(self)
	print(Globals.celestialbodies)
	pass

func _physics_process(delta):
	if stableorbit == true and !is_star:
		Gravity(delta)
	if stableorbit == false:
		Gravity(delta)
	else:
		linear_velocity = Vector2.ZERO
	
func Gravity(_delta):
		for otherbody in Globals.celestialbodies:
			if otherbody != self:
				var otherbodyMass = otherbody.mass
				var direction = self.get_global_position() - otherbody.get_global_position()
				var distance = direction.length()
				
				var forceMag = G * ((mass * otherbodyMass) / (distance * distance))
				var force = direction.normalized() * forceMag
				
				apply_central_force(-force)


func _on_planet_instability():
	pass # Replace with function body.
