extends GameObject

func _ready():
	._ready()
	._place_lights(direction)

func _on_Area2D_input_event(viewport, event, shape_idx) -> void:
	._on_Area2D_input_event(viewport, event, shape_idx)
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			_manage_lights(event)
		if event.button_index == BUTTON_RIGHT and event.is_pressed() == false:
			.replace_lights()

func _manage_lights(event)->void:
	if event.is_pressed():
		._deplace_lights()
	else:
		._place_lights(direction)
