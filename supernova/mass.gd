extends GPUParticles2D
var mass
var heat
var loss = false
func _physics_process(_delta: float) -> void:
	
	var density = get_parent().scale
	if loss == false:
		heat = get_parent().heat
		mass = get_parent().mass

		scale = Vector2(mass, mass) * 0.002
		
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
		
		
