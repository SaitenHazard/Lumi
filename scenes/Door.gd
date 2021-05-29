extends GameObject

onready var sprite_closed = load("res://sprites/door.png")
onready var sprite_open = load("res://sprites/turret.png")

onready var BUTTON = get_node('/root/Game/CanvasLayer/UI/Button')

func place_lights(var light_in_direction, var tex : Texture = tex_light_white)->void:
	if tex == tex_light_white:
		if (direction == direction_down && light_in_direction == direction_up) or \
		(direction == direction_up && light_in_direction == direction_down) or \
		(direction == direction_right && light_in_direction == direction_left) or \
		(direction == direction_left && light_in_direction == direction_right):
			self.texture = sprite_open
			BUTTON.enable()

func deplace_lights()->void:
	self.texture = sprite_closed
	BUTTON.disable()
