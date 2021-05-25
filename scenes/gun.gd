extends Game_object

onready var LIGHT = preload("res://scenes/Light.tscn")
onready var max_lights : float = get_node('/root/Game/Tiles').get_mapsize().x

func _ready():
	pass # Replace with function body.
