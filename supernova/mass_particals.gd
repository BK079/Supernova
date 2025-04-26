extends GPUParticles2D


func _physics_process(delta: float) -> void:
	var mass = clamp(get_parent().mass, 0, 2000)
	var heat = clamp(get_parent().heat, 0, 200)
	
	var density = get_parent().scale
	

	scale = Vector2(mass, heat) * 0.005
	
	self.process_material.set("scale", scale*density)
	if mass >= 20:
		self.modulate = Color(1, 0, 0)
	if mass >= 40:
		self.modulate = Color(0.8, 0.2, 0)
	if mass >= 60:
		self.modulate = Color(0.5, 0.5, 0)
	if mass >= 80:
		self.modulate = Color(0, 1, 0)
	if mass >= 100:
		self.modulate = Color(0.2, 0.6, 0.2)
	if mass >= 120:
		self.modulate = Color(1, 1, 1)
	if mass >= 140:
		self.modulate = Color(1, 0, 1)
	if mass >= 160:
		self.modulate = Color(0, 0.5, 1)

	
	
