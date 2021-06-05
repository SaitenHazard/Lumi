extends Sprite

class_name GameObject

const direction_up : Vector2 = Vector2(0,-1)
const direction_down : Vector2 = Vector2(0,1)
const direction_left : Vector2 = Vector2(-1,0)
const direction_right : Vector2 = Vector2(1,0)

const color_blue : String = "blue"
const color_red : String = "red"
const color_yellow : String = "yellow"
const color_purple : String = "purple"
const color_orange : String = "orange"
const color_green : String = "green"

onready var tex_light_blue = load("res://sprites/lights/light_blue.png")
onready var tex_light_red = load("res://sprites/lights/light_red.png")
onready var tex_light_yellow = load("res://sprites/lights/light_yellow.png")
onready var tex_light_purple = load("res://sprites/lights/light_purple.png")
onready var tex_light_green = load("res://sprites/lights/light_green.png")
onready var tex_light_orange = load("res://sprites/lights/light_orange.png")

onready var IMMOVABLE = load("res://scenes/Immovable.tscn")
onready var UNROTATABLE = load("res://scenes/Unrotatable.tscn")
onready var IMMOVABLE_AND_UNROTATABLE = load("res://scenes/Immovable_and_unrotatable.tscn")

onready var OBJECTMANAGER = get_node('/root/Game/ObjectManager')
onready var SOUNDS = get_node('/root/Game/Sounds')
onready var LIGHT = get_node("Light")
onready var GAME = get_node('/root/Game/')

onready var size : Vector2 = GAME.get_mapsize()
onready var max_lights : float = size.x

export var coordinate : Vector2 = Vector2(5,5)
export var direction : Vector2 = Vector2(0,-1)
export var immovable : bool = false
export var unrotatable : bool = false
export var color : String = color_blue

var lights : Array
var being_dragged : bool = false
var _offset : float 
var cell_size : float

func get_being_dragged() -> bool:
	return being_dragged

func get_coordinate() -> Vector2:
	return coordinate
	
func get_direction() -> Vector2:
	return direction

func _ready() -> void:
	_initialize()
	_spawn_lights()
	_set_immovable()

func _set_immovable() -> void:
	if name == "Filter":
		print('in')
	if immovable && unrotatable:
		var m_immovable_and_unrotatable = IMMOVABLE_AND_UNROTATABLE.instance()
		get_node('/root/Game/ObjectManager/Details').add_child(m_immovable_and_unrotatable)
		m_immovable_and_unrotatable.position = Vector2(
			_offset + coordinate.x * cell_size, _offset + 
			coordinate.y * cell_size)
		return
	
	if immovable:
		var m_immovable = IMMOVABLE.instance()
		get_node('/root/Game/ObjectManager/Details').add_child(m_immovable)
		m_immovable.position = Vector2(
			_offset + coordinate.x * cell_size, _offset + 
			coordinate.y * cell_size)

	if unrotatable:
		var m_unrotatable = UNROTATABLE.instance()
		self.add_child(m_unrotatable)
		m_unrotatable.position = Vector2(0, 0)

func _initialize() -> void:
	get_node('Area2D/CollisionShape2D').shape.extents = Vector2(50,50)
	_offset = GAME.get_positon_offset()
	cell_size = GAME.get_cell_size()

func _process(delta) -> void:
	_set_position()
	_set_direction()

func _set_direction() -> void:
	if direction == direction_up:
		self.rotation = deg2rad(0)
	elif direction == direction_right:
		self.rotation = deg2rad(90)
	elif direction == direction_down:
		self.rotation = deg2rad(180)
	elif direction == direction_left:
		self.rotation = deg2rad(-90)

func _set_position() -> void :
	if being_dragged == false:
		
		if coordinate.x < 0:
			coordinate.x = 0
		if coordinate.y < 0:
			coordinate.y = 0
		if coordinate.x > size.x-1:
			coordinate.x = size.x-1
		if coordinate.y > size.y-1:
			coordinate.y = size.y-1
			
		self.position = Vector2(
		_offset + coordinate.x * cell_size, _offset + coordinate.y * cell_size)
	else:
		self.position =  get_viewport().get_mouse_position()

func _on_Area2D_input_event(viewport, event, shape_idx) -> void:
	var block = OBJECTMANAGER.get_block(coordinate)
	
	if block != null:
		return
		
	if event is InputEventMouseButton:
		if immovable == false && event.button_index == BUTTON_LEFT:
			_drag_drop(event)
			_set_coordinate()
		elif event.button_index == BUTTON_RIGHT:
			if unrotatable == false:
				_change_direction(event)
		OBJECTMANAGER.replace_lights_all()

func _drag_drop(event) -> void:
	if event.is_pressed():
		being_dragged = true
		SOUNDS.get_node('PickUp').play()
	else:
		SOUNDS.get_node('Drop').play()
		being_dragged = false

func _change_direction(event) -> void:
	if event.is_pressed() == false:
		SOUNDS.get_node('Rotate').play()
		if direction == direction_up:
			direction = direction_right
		elif direction == direction_right:
			direction = direction_down
		elif direction == direction_down:
			direction = direction_left
		else:
			direction = direction_up

func _set_coordinate() -> void:
	var mouse_coordinate : Vector2 = Vector2.ZERO
	var mouse_position = get_viewport().get_mouse_position()
	mouse_coordinate.x = round((mouse_position.x - _offset) / cell_size)
	mouse_coordinate.y = round((mouse_position.y - _offset) / cell_size)
	var interacted_with  = OBJECTMANAGER.get_interaction_object(
		mouse_coordinate)
	if(interacted_with != null):
		return
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

func place_lights(var light_direction, var color : String)->void:
	if being_dragged:
		return
		
	if light_direction == null:
		light_direction = direction
		
	for i in range(lights.size()):
		var light_coordinate = Vector2(
			coordinate.x + ((i+1)*light_direction.x), coordinate.y + ((i+1)*light_direction.y))
	
		if name == 'Redirect':
			'in'
			
		var interacted_with  = OBJECTMANAGER.get_interaction_object(light_coordinate)
		
		
		if interacted_with != null:
			interacted_with.place_lights(light_direction, color)
			break
			
		
		if light_direction == direction_left || light_direction == direction_right:
			lights[i].rotation = deg2rad(90)
		else:
			lights[i].rotation = deg2rad(0)
		
		lights[i].texture = _get_light_texture(color)
		lights[i].visible = true
		lights[i].position = Vector2(
		self._offset + light_coordinate.x * self.cell_size, self._offset + 
		light_coordinate.y * self.cell_size)

func _get_light_texture(color : String) -> Texture:
	if color == color_red:
		return tex_light_red
	elif color == color_blue:
		return tex_light_blue
	elif color == color_yellow:
		return tex_light_yellow
	elif color == color_green:
		return tex_light_green
	elif color == color_orange:
		return tex_light_orange
	else:
		return tex_light_purple
