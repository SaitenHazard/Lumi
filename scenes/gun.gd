extends Game_object

onready var LIGHT = preload("res://scenes/Light.tscn")

onready var lights : Array
onready var max_lights : float = Tiles.get_mapsize().x

func _ready():
	._ready()
	call_deferred("_spawn_lights")
	call_deferred("_place_lights")
	
func _on_Area2D_input_event(viewport, event, shape_idx) -> void:
	._on_Area2D_input_event(viewport, event, shape_idx)
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			_manage_lights(event)
		if event.button_index == BUTTON_RIGHT and event.is_pressed() == false:
			_replace_lights()
			
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

func _replace_lights():
	_deplace_lights()
	_place_lights()

func _deplace_lights():
	for i in range(lights.size()):
		lights[i].visible = false

func _place_lights():
	for i in range(lights.size()):
		var light_coordinate = Vector2(
			coordinate.x + ((i+1)*direction.x), coordinate.y + ((i+1)*direction.y))
		lights[i].visible = true
		lights[i].position = Vector2(
		_offset + light_coordinate.x * cell_size, _offset + light_coordinate.y * cell_size)
