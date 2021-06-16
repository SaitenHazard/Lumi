extends GameObject

onready var sprite_closed = load("res://sprites/filters/filter_"+color+".png")

func _ready():
	self.texture = sprite_closed
	._ready()

func place_lights(var light_in_direction, var light_color)->void:
	if (light_in_direction == direction or light_in_direction == (direction *-1)): 
		.place_lights(light_in_direction, color)
