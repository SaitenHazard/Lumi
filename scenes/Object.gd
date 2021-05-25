extends Sprite

class_name Game_object

onready var Tiles = get_node('/root/Game/Tiles')
export var coordinate : Vector2 = Vector2(5,5)

var left_mousebutton_pressed : bool = false
var _offset : float 
var cell_size : float

func _ready():
	_offset = Tiles.get_positon_offset()
	cell_size = Tiles.get_cell_size()

func _process(delta) -> void :
	_set_position()

func _set_position() -> void :
	if left_mousebutton_pressed == false:
		self.position = Vector2(
		_offset + coordinate.x * cell_size, _offset + coordinate.y * cell_size)
	else:
		self.position =  get_viewport().get_mouse_position()

func _on_Area2D_input_event(viewport, event, shape_idx) -> void:
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT:
		if event.is_pressed():
			left_mousebutton_pressed = true
		else:
			left_mousebutton_pressed = false
			_set_coordinate()
			
func _set_coordinate():
	var mouse_coordinate : Vector2
	var mouse_position = get_viewport().get_mouse_position()
	mouse_coordinate.x = round((mouse_position.x - _offset) / cell_size)
	mouse_coordinate.y = round((mouse_position.y - _offset) / cell_size)
	coordinate = mouse_coordinate
