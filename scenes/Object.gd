extends Sprite

class_name GameObject

onready var ObjectManager = get_node('/root/Game/ObjectManager')

onready var TILES = get_node('/root/Game/Tiles')
onready var LIGHT = get_node("Light")

onready var max_lights : float = TILES.get_mapsize().x

export var coordinate : Vector2 = Vector2(5,5)
export var direction : Vector2 = Vector2(0,-1)
export var lights : Array

var left_mousebutton_pressed : bool = false
var _offset : float 
var cell_size : float

var interacted_with = null

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
	if left_mousebutton_pressed == false:
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

func _drag_drop(event) -> void:
	if event.is_pressed():
		left_mousebutton_pressed = true
	else:
		left_mousebutton_pressed = false

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
	for i in range(max_lights):
		var light =  LIGHT.duplicate()
		lights.push_back(light)
		get_node('/root/Game/Tiles').add_child(light)

func replace_lights()->void:
	deplace_lights()
	place_lights(direction)

func deplace_lights()->void:
	for i in range(lights.size()):
		lights[i].visible = false
	print('in')
	if interacted_with != null:
		interacted_with.deplace_lights()
		interacted_with = null

func place_lights(direction : Vector2)->void:
	for i in range(lights.size()):
		var light_coordinate = Vector2(
			coordinate.x + ((i+1)*direction.x), coordinate.y + ((i+1)*direction.y))
		interacted_with  = ObjectManager.get_mirror(light_coordinate)
		if(interacted_with != null):
			interacted_with.place_reflected_lights(direction)
			break
		lights[i].visible = true
		lights[i].position = Vector2(
		self._offset + light_coordinate.x * self.cell_size, self._offset + light_coordinate.y * self.cell_size)
