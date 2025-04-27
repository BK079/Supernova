extends GPUParticles2D

var loss = false
var heat 
var mass 

func _physics_process(_delta: float) -> void:
	
	if loss == false:
		heat = get_parent().heat
		mass = get_parent().mass
		scale = Vector2(heat, heat) * 0.01
		
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
