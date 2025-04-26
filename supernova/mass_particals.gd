extends GPUParticles2D


func _physics_process(delta: float) -> void:
	var mass = clamp(get_parent().mass, 0, 2000)
	var density = get_parent().scale
	

	scale = Vector2(mass, mass) * 0.005
	
	self.process_material.set("scale", scale*density)
	

	
	
