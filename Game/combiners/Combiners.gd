extends GameObject

var color_in_one = null
var color_in_two = null

func place_lights(var light_in_direction, var color : String)->void:
	if light_in_direction == direction or light_in_direction == (direction *-1): 
		if color_in_one == null:
			color_in_one = color
		else:
			color_in_two = color
			
	if color_in_two == null || color_in_one == null:
		return
	
	if color_in_one == color_in_two:
		return
	
	var emit_direction = get_emit_direction()
	
	if color_in_one == color_blue and color_in_two == color_red or \
	color_in_one == color_red and color_in_two == color_blue:
		.place_lights(emit_direction, color_purple)
	elif color_in_one == color_yellow and color_in_two == color_red or \
	color_in_one == color_red and color_in_two == color_yellow:
		.place_lights(emit_direction, color_orange)
	else:
		.place_lights(emit_direction, color_green)

func get_emit_direction() -> Vector2:
	if direction == direction_up:
		return Vector2(1,0)
	elif direction == direction_right:
		return Vector2(0,1)
	elif direction == direction_down:
		return Vector2(-1,0)
	else:
		return Vector2(0,-1)
		
func deplace_lights() -> void:
	color_in_one = null
	color_in_two = null
	.deplace_lights()
