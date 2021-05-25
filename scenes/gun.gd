extends Game_object

onready var LIGHT = preload("res://scenes/Light.tscn")

onready var lights : Array
onready var max_lights : float = Tiles.get_mapsize().x

func _ready():
	call_deferred("_spawn_lights")
	call_deferred("_place_lights")

func _spawn_lights():
	for i in range(max_lights):
		var light =  LIGHT.instance()
		lights.push_back(light)
		get_node('/root/Game/Tiles').add_child(light)

func _place_lights():
	var direction = Vector2(0,-1)
	
	for i in range(lights.size()-1):
		var light_coordinate = Vector2(
			coordinate.x + ((i+1)*direction.x), coordinate.y + ((i+1)*direction.y))
			
		lights[i].visible = true
		
		lights[i].position = Vector2(
		_offset + light_coordinate.x * cell_size, _offset + light_coordinate.y * cell_size)
