extends Sprite

class_name GameObject

onready var ObjectManager = get_node('/root/Game/ObjectManager')

onready var TILES = get_node('/root/Game/Tiles')
onready var LIGHT = get_node("Light")

onready var max_lights : float = TILES.get_mapsize().x

export var coordinate : Vector2 = Vector2(5,5)
export var direction : Vector2 = Vector2(0,-1)
export var lights : Array

var being_dragged : bool = false
var _offset : float 
var cell_size : float

func get_coordinate() -> Vector2:
	return coordinate
	
func get_direction() -> Vector2:
	return direction

func _ready() -> void:
	_spawn_lights()
	_offset = TILES.get_positon_offset()
	cell_size = TILES.get_cell_size()

func _process(delta) -> void:
	_set_position()
	_set_direction()

func _set_direction() -> void:
	if direction == Vector2(0,-1):
		self.rotation = deg2rad(0)
	elif direction == Vector2(1, 0):
		self.rotation = deg2rad(90)
	elif direction == Vector2(0, 1):
		self.rotation = deg2rad(180)
	elif direction == Vector2(-1, 0):
		self.rotation = deg2rad(-90)

func _set_position() -> void :
	if being_dragged == false:
		self.position = Vector2(
		_offset + coordinate.x * cell_size, _offset + coordinate.y * cell_size)
	else:
		self.position =  get_viewport().get_mouse_position()

func _on_Area2D_input_event(viewport, event, shape_idx) -> void:
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			_drag_drop(event)
			_set_coordinate()
		elif event.button_index == BUTTON_RIGHT:
			_change_direction(event)
		ObjectManager.replace_lights_all()

func _drag_drop(event) -> void:
	if event.is_pressed():
		being_dragged = true
	else:
		being_dragged = false

func _change_direction(event) -> void:
	if event.is_pressed() == false:
		if direction == Vector2(0,-1):
			direction = Vector2(1,0)
		elif direction == Vector2(1, 0):
			direction = Vector2(0,1)
		elif direction == Vector2(0, 1):
			direction = Vector2(-1,0)
		else:
			direction = Vector2(0,-1)

func _set_coordinate() -> void:
	var mouse_coordinate : Vector2 = Vector2.ZERO
	var mouse_position = get_viewport().get_mouse_position()
	mouse_coordinate.x = round((mouse_position.x - _offset) / cell_size)
	mouse_coordinate.y = round((mouse_position.y - _offset) / cell_size)
	coordinate = mouse_coordinate
	
func _spawn_lights()->void:
	var root_game = get_node('/root/Game/ObjectManager/Lights')
	for i in range(max_lights):
		var light =  LIGHT.duplicate()
		lights.push_back(light)
		root_game.add_child(light)

func deplace_lights()->void:
	for i in range(lights.size()):
		lights[i].visible = false

func place_lights(var light_direction : Vector2)->void:
	if being_dragged:
		return
	if light_direction == Vector2(-1,-1):
		light_direction = direction
		
	for i in range(lights.size()):
		var light_coordinate = Vector2(
			coordinate.x + ((i+1)*light_direction.x), coordinate.y + ((i+1)*light_direction.y))
		var interacted_with  = ObjectManager.get_interaction_object(light_coordinate)
		if(interacted_with != null):
			interacted_with.place_lights(light_direction)
			break
		lights[i].visible = true
		lights[i].position = Vector2(
		self._offset + light_coordinate.x * self.cell_size, self._offset + light_coordinate.y * self.cell_size)
