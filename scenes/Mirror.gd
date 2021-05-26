extends Game_object

func _set_direction() -> void:
	if direction == Vector2(0,-1) or direction == Vector2(0, 1):
		self.flip_v = false
	elif direction == Vector2(1, 0) or direction == Vector2(-1, 0):
		self.flip_v = true

func _on_Area2D_input_event(viewport, event, shape_idx) -> void:
	._on_Area2D_input_event(viewport, event, shape_idx)
	if event is InputEventMouseButton:
		if event.is_pressed() == false:
			_replace_all_lights()

func _replace_all_lights() -> void:
	pass
