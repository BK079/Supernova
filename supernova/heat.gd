extends GPUParticles2D

func _physics_process(_delta: float) -> void:
	var heat = clamp(get_parent().heat, 0, 1000)
	var mass = clamp(get_parent().mass, 0, 1000)
	
	scale = Vector2(heat, mass) * 0.01
	
	self.process_material.set("angular_velocity", -scale * -heat)

	if heat >= 50:
		self.modulate = Color(1, 0, 0)
	if heat >= 150:
		self.modulate = Color(0.8, 0.2, 0)
	if heat >= 300:
		self.modulate = Color(0.5, 0.5, 0)
	if heat >= 450:
		self.modulate = Color(0, 1, 0)
	if heat >= 550:
		self.modulate = Color(0.2, 0.6, 0.2)
	if heat >= 700:
		self.modulate = Color(1, 1, 1)
	if heat >= 825:
		self.modulate = Color(1, 0, 1)
	if heat >= 900:
		self.modulate = Color(0, 0.5, 1)
	#self.modulate = Color(lerp())
