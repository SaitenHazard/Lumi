extends GameObject

func _set_direction() -> void:
	if direction == Vector2(0,-1) or direction == Vector2(0, 1):
		self.flip_v = false
	elif direction == Vector2(1, 0) or direction == Vector2(-1, 0):
		self.flip_v = true

func place_lights(var light_in_direction:Vector2, var tex : Texture = null)->void:
	print(tex.get_name())
	var reflected_light_direction = get_reflected_direction(light_in_direction)
	.place_lights(reflected_light_direction, tex)

func get_reflected_direction(light_direction)->Vector2:
	if direction == Vector2(0, 1) || direction == Vector2(0,-1):
		if light_direction == Vector2(1,0):
			return Vector2(0,1)
		elif light_direction == Vector2(-1,0):
			return Vector2(0,-1)
		elif light_direction == Vector2(0,1):
			return Vector2(1,0)
		else:
			return Vector2(-1,0)
	else:
		if light_direction == Vector2(1,0):
			return Vector2(0,-1)
		elif light_direction == Vector2(-1,0):
			return Vector2(0,1)
		elif light_direction == Vector2(0,1):
			return Vector2(-1,0)
		else:
			return Vector2(1,0)
