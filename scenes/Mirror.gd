extends GameObject

onready var ObjectManager = get_node('/root/Game/ObjectManager')

func _set_direction() -> void:
	if direction == Vector2(0,-1) or direction == Vector2(0, 1):
		self.flip_v = false
	elif direction == Vector2(1, 0) or direction == Vector2(-1, 0):
		self.flip_v = true

func _on_Area2D_input_event(viewport, event, shape_idx) -> void:
	._on_Area2D_input_event(viewport, event, shape_idx)
	if event is InputEventMouseButton:
		if event.is_pressed() == false:
			ObjectManager.replace_all_lights()

func get_reflected_direction(light_direction)->Vector2:
	if direction == Vector2(0, 1) || direction == Vector2(0,-1):
		if light_direction == Vector2(1,0):
			return Vector2(0,1)
		elif light_direction == Vector2(-1,0):
			return Vector2(0,-1)
		elif light_direction == Vector2(0,1):
			return Vector2(1,0)
		else:
			return Vector2(-1,0)
	else:
		if light_direction == Vector2(1,0):
			return Vector2(0,-1)
		elif light_direction == Vector2(-1,0):
			return Vector2(0,1)
		elif light_direction == Vector2(0,1):
			return Vector2(-1,0)
		else:
			return Vector2(1,0)
