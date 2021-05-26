extends Game_object

onready var LIGHT = preload("res://scenes/Light.tscn")

onready var lights : Array
onready var max_lights : float = Tiles.get_mapsize().x

onready var mirrors : Array

func _ready():
	._ready()
	call_deferred("_spawn_lights")
	call_deferred("_place_lights")
	mirrors = _get_mirrors()
	
func _get_mirrors() -> Array:
	var mirrors = get_node('/root/Game/ObjectManager/Mirrors').get_children()
	return mirrors

func _on_Area2D_input_event(viewport, event, shape_idx) -> void:
	._on_Area2D_input_event(viewport, event, shape_idx)
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			_manage_lights(event)
		if event.button_index == BUTTON_RIGHT and event.is_pressed() == false:
			replace_lights()
			
func _manage_lights(event):
	if event.is_pressed():
		_deplace_lights()
	else:
		_place_lights()

func _spawn_lights():
	for i in range(max_lights):
		var light =  LIGHT.instance()
		lights.push_back(light)
		get_node('/root/Game/Tiles').add_child(light)

func replace_lights():
	_deplace_lights()
	_place_lights()

func _deplace_lights():
	for i in range(lights.size()):
		lights[i].visible = false

func _place_lights():
	for i in range(lights.size()):
		var light_coordinate = Vector2(
			coordinate.x + ((i+1)*direction.x), coordinate.y + ((i+1)*direction.y))
		var mirror_direction  = _get_mirror_direction(light_coordinate)
		if mirror_direction != null:
			_place_lights_reflected(i, light_coordinate, mirror_direction)
			break
		_set_light_position(lights[i], light_coordinate)

func _place_lights_reflected(var index, var initial_coordinate, var direction) -> void:
	for i in range(index,lights.size()):
		var light_coordinate = Vector2(
			initial_coordinate.x + ((i+1)*direction.x), initial_coordinate.y + ((i+1)*direction.y))
		_set_light_position(lights[i], light_coordinate)

func _set_light_position(light, light_coordinate) -> void:
	light.visible = true
	light.position = Vector2(
		_offset + light_coordinate.x * cell_size, _offset + light_coordinate.y * cell_size)
	
func _get_mirror_direction(var cooridnate : Vector2):
	for i in range(mirrors.size()):
		if mirrors[i].get_coordinate() == cooridnate:
			return mirrors[i].get_direction() 
	return null
