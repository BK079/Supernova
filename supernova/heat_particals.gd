extends GPUParticles2D

func _physics_process(delta: float) -> void:
	var heat = clamp(get_parent().heat, 0, 2000)
	var mass = clamp(get_parent().mass, 0, 200)
	
	scale = Vector2(heat, mass) * 0.01
	
	self.process_material.set("angular_velocity", -scale * -heat * -mass)

	if heat >= 20:
		self.modulate = Color(1, 0, 0)
	if heat >= 40:
		self.modulate = Color(0.8, 0.2, 0)
	if heat >= 60:
		self.modulate = Color(0.5, 0.5, 0)
	if heat >= 80:
		self.modulate = Color(0, 1, 0)
	if heat >= 100:
		self.modulate = Color(0.2, 0.6, 0.2)
	if heat >= 120:
		self.modulate = Color(1, 1, 1)
	if heat >= 140:
		self.modulate = Color(1, 0, 1)
	if heat >= 160:
		self.modulate = Color(0, 0.5, 1)
	#self.modulate = Color(lerp())
