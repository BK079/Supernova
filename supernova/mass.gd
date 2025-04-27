extends GPUParticles2D


func _physics_process(_delta: float) -> void:
	var mass = clamp(get_parent().mass, 10, 1000)
	var heat = clamp(get_parent().heat, 10, 1000)
	
	var density = get_parent().scale
	

	scale = Vector2(mass, heat) * 0.002
	
	self.process_material.set("scale", scale*density)
	if mass >= 50:
		self.modulate = Color(1, 0, 0)
	if mass >= 150:
		self.modulate = Color(0.8, 0.2, 0)
	if mass >= 300:
		self.modulate = Color(0.5, 0.5, 0)
	if mass >= 450:
		self.modulate = Color(0, 1, 0)
	if mass >= 550:
		self.modulate = Color(0.2, 0.6, 0.2)
	if mass >= 700:
		self.modulate = Color(1, 1, 1)
	if mass >= 825:
		self.modulate = Color(1, 0, 1)
	if mass >= 900:
		self.modulate = Color(0, 0.5, 1)
	
	
