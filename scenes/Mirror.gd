extends GameObject

func place_lights(var light_in_direction, var tex : Texture = null)->void:
	var reflected_light_direction = get_reflected_direction(light_in_direction)
	print(reflected_light_direction)
	if reflected_light_direction != null:
		.place_lights(reflected_light_direction, tex)

func get_reflected_direction(light_direction):
	if light_direction == direction_right:
		if direction == direction_down:
			return direction_down
		elif direction == direction_left:
			return direction_up
		else:
			return null
			
	if light_direction == direction_down:
		if direction == direction_up:
			return direction_right
		elif direction == direction_left:
			return direction_left
		else:
			return null
			
	if light_direction == direction_left:
		if direction == direction_up:
			return direction_up
		elif direction == direction_right:
			return direction_down
		else:
			return null
	
	if light_direction == direction_up:
		if direction == direction_right:
			return direction_right
		elif direction == direction_down:
			return direction_left
		else:
			return null
