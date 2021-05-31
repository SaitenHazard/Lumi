extends GameObject

onready var tex = load("res://sprites/sources/source_"+color+".png")

func _ready():
	texture = tex

func place_lights_initial(var light_in_direction, var light_color)->void:
	.place_lights(light_in_direction, color)

func place_lights(var light_in_direction, var light_color)->void:
	return
