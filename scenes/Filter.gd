extends GameObject

func place_lights(var light_in_direction, var tex : Texture = tex_light_red)->void:
	if (light_in_direction == direction_left or light_in_direction == direction_right) and \
	 (direction == direction_left or direction ==  direction_right): 
		.place_lights(light_in_direction, tex_light_red)
		
	if (light_in_direction == direction_up or light_in_direction == direction_down) and \
	 (direction == direction_up or direction ==  direction_down): 
		.place_lights(light_in_direction, tex_light_red)
