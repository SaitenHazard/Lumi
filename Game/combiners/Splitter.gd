extends GameObject

var lights2 : Array

func _ready():
	_spawn_lights2()
	._ready()

func _spawn_lights2()->void:
	var root_game = get_node('/root/Game/ObjectManager/Lights')
	if root_game == null:
		return
	for i in range(max_lights):
		var light =  LIGHT.duplicate()
		lights2.push_back(light)
		root_game.add_child(light)

func place_lights(var light_in_direction, var color : String)->void:
	if direction == direction_up && light_in_direction == direction_left \
	or direction == direction_down && light_in_direction == direction_right:
		.place_lights(direction_up, color)
		place_lights2(direction_down, color)
		
	if direction == direction_right && light_in_direction == direction_up \
	or direction == direction_left && light_in_direction == direction_down:
		.place_lights(direction_left, color)
		place_lights2(direction_right, color)

func place_lights2(light_direction, color):
	for i in range(lights2.size()):
		var light_coordinate = Vector2(
			coordinate.x + ((i+1)*light_direction.x), coordinate.y + ((i+1)*light_direction.y))
		var interacted_with  = OBJECTMANAGER.get_interaction_object(light_coordinate)
		
		if interacted_with != null:
			interacted_with.place_lights(light_direction, color)
			break
		
		if light_direction == direction_left || light_direction == direction_right:
			lights2[i].rotation = deg2rad(90)
		else:
			lights2[i].rotation = deg2rad(0)
		
		lights2[i].texture = _get_light_texture(color)
		lights2[i].visible = true
		lights2[i].position = Vector2(
		self._offset + light_coordinate.x * self.cell_size, self._offset + 
		light_coordinate.y * self.cell_size)

func deplace_lights()->void:
	for i in range(lights.size()):
		lights[i].visible = false
		
	for i in range(lights2.size()):
		lights2[i].visible = false
