extends GPUParticles2D

func _physics_process(delta: float) -> void:
	var heat = clamp(get_parent().heat, 0, 2000)
	scale = Vector2(heat, heat) * 0.01
	
	self.process_material.set("angular_velocity", -scale * -heat)
