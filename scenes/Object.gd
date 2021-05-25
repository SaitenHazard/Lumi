extends Sprite

class_name Game_object

var coordinate : Vector2 = Vector2(5,5)
var left_mousebutton_pressed : bool = false

func _ready():
	pass # Replace with function body.

func _process(delta) -> void :
	_set_position()

func _set_position() -> void :
	if left_mousebutton_pressed == false:
		self.position = Vector2(
		24 + coordinate.x * 48, 24 + coordinate.y * 48)
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
	mouse_coordinate.x = round((mouse_position.x - 24) / 48)
	mouse_coordinate.y = round((mouse_position.y - 24) / 48)
	coordinate = mouse_coordinate
