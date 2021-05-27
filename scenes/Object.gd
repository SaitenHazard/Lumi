extends Sprite

class_name Game_object

onready var Tiles = get_node('/root/Game/Tiles')
export var coordinate : Vector2 = Vector2(5,5)
export var direction : Vector2 = Vector2(0,-1)

var left_mousebutton_pressed : bool = false
var _offset : float 
var cell_size : float

func get_coordinate() -> Vector2:
	return coordinate
	
func get_direction() -> Vector2:
	return direction

func _ready() -> void:
	_offset = Tiles.get_positon_offset()
	cell_size = Tiles.get_cell_size()

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
