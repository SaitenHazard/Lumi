extends GameObject

onready var sprite_closed = load("res://sprites/goals/goal_"+color+".png")
onready var sprite_open = load("res://sprites/sources/source_"+color+".png")

var already_lit = false;

func is_open():
	if texture == sprite_open:
		return true
	else:
		return false

func place_lights(var light_in_direction, var light_color : String)->void:
	if (light_color == color):
		if (direction == light_in_direction * -1):
			if !already_lit:
				SOUNDS.get_node('Destroy').play()
			self.texture = sprite_open
			already_lit = true
			return
	
	already_lit = false

func deplace_lights()->void:
	self.texture = sprite_closed
