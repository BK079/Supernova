extends RigidBody2D

@export var thrust = 0.5
@export var heat : float
@export var density : float



signal absorbed
signal massheatupdate

func _onready():
	$CollisionShape2D.shape.radius = max(mass*density, 1)
	$Sprite2D.scale = Vector2(max(mass*density, 0.01), max(mass*density, 0.01))
	Globals.celestialbodies.append(self)



func _integrate_forces(state):
	var disttomouse = get_global_mouse_position() - get_global_position()
	if Input.is_action_pressed("Onmouseleft"):
		state.apply_force(disttomouse*thrust*mass)
		mass = clamp(mass-1, 10, 1000)
	if Input.is_action_pressed("Onmouseright"):
		state.apply_force(disttomouse*thrust*mass)
		heat -= 1
	$CollisionShape2D.shape.radius = max(mass*density, 1)
	$Sprite2D.scale = Vector2(max(mass*density*0.03, 0.01), max(mass*density*0.03, 0.01))
	Gravity()
	
		

func Gravity():
	for otherbody in Globals.celestialbodies:
		if otherbody != self:
			var otherbodyMass = otherbody.mass
			var direction = self.get_global_position() - otherbody.get_global_position()
			var distance = direction.length()
				
			var forceMag = Globals.G * ((mass * otherbodyMass) / (distance * distance))
			var force = direction.normalized() * forceMag
			apply_central_force(-force)



func _on_body_entered(body):
	if body.is_in_group("Planets"):
		if body.type == 1:
			mass = clamp(mass+body.mass, 10, 1000)
		if body.type == 2:
			mass = clamp(mass+body.mass*0.5, 10, 1000)
			heat += body.mass*0.5
		if body.type == 3:
			heat += body.mass
		Globals.celestialbodies.erase(body)
		body.queue_free()
	if body.is_in_group("Celestials"):
		print(body.get_rid())
		print(body.mass)
		if body.mass > self.mass:
			absorbed.emit(body)
			queue_free()
		if self.mass > body.mass:
			mass = clamp(mass+body.mass, 10, 1000)
			heat += body.mass
			Globals.celestialbodies.erase(body)
			print(Globals.celestialbodies)
			body.queue_free()
	massheatupdate.emit(mass, heat)
