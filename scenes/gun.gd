extends GameObject

#func _ready():
#	._ready()

func place_lights(var light_in_direction, var tex : Texture = tex_light_white)->void:
	.place_lights(light_in_direction, tex_light_white)

#func _on_Area2D_input_event(viewport, event, shape_idx) -> void:
#	._on_Area2D_input_event(viewport, event, shape_idx)
#	if event is InputEventMouseButton:
#		if event.button_index == BUTTON_LEFT:
#			_manage_lights(event)
#		if event.button_index == BUTTON_RIGHT and event.is_pressed() == false:
#			.replace_lights()
#
#func _manage_lights(event)->void:
#	if event.is_pressed():
#		.deplace_lights()
#	else:
#		.place_lights(direction)
