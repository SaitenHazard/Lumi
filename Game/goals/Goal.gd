extends GameObject

onready var sprite_closed = load("res://sprites/goals/goal_"+color+".png")
onready var sprite_open = load("res://sprites/sources/source_"+color+".png")


func is_open():
	if texture == sprite_open:
		return true
	else:
		return false

func place_lights(var light_in_direction, var light_color : String)->void:
	if (light_color == color):
		if (direction == light_in_direction * -1):
			self.texture = sprite_open

func deplace_lights()->void:
	print("res://sprites/goals/goal_"+color+".png")
	print(sprite_closed)
	self.texture = sprite_closed
