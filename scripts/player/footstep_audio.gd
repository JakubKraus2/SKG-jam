extends AudioStreamPlayer3D


func play_footstep():
	if owner.current_surface_type == "ground":
		set_stream(owner.footsteps_ground)
	else:
		set_stream(owner.footsteps_water)
	play()

func emit_particle(foot: int = 0):
	if owner.current_surface_type == "water":
		if foot == 0:
			$"../WaterParticleRight".restart()
		else:
			$"../WaterParticleLeft".restart()
