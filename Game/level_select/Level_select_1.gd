extends Sprite

onready var SOUNDS = get_node('/root/Game/Sounds')
onready var GAME = get_node('/root/Game/')

onready var size : Vector2 = GAME.get_mapsize()
onready var max_lights : float = size.x
onready var play_coordinate : Vector2 = get_node('/root/Game/Play').get_coordinate()
onready var path = "res://levels/level_"+str(select_level)+".tscn"
onready var transition = get_node('/root/Game/SceneTransitionRect') 
onready var CAMERA_SHAKE = get_node("/root/Game/Camera2D")

export var coordinate : Vector2 = Vector2(5,5)
export var select_level : String = ''

var being_dragged : bool = false
var _offset : float 
var cell_size : float

var blocked : bool = false

func get_being_dragged() -> bool:
	return being_dragged

func get_coordinate() -> Vector2:
	return coordinate

func _ready() -> void:
	_initialize()

func _initialize() -> void:
	get_node('Area2D/CollisionShape2D').shape.extents = Vector2(40,40)
	_offset = GAME.get_positon_offset()
	cell_size = GAME.get_cell_size()

func _process(delta) -> void:
	_set_position()

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
	if event is InputEventMouseButton:
		if blocked:
			_now_allowed()
			return
		if event.button_index == BUTTON_LEFT:
			_drag_drop(event)
			_set_coordinate()
			
func _now_allowed():
	SOUNDS.get_node('Wrong').play()
	CAMERA_SHAKE.shake(0.2,15,8)

func _drag_drop(event) -> void:
	if event.is_pressed():
		being_dragged = true
		SOUNDS.get_node('PickUp').play()
	else:
		SOUNDS.get_node('Drop').play()
		being_dragged = false

func _set_coordinate() -> void:
	var mouse_coordinate : Vector2 = Vector2.ZERO
	var mouse_position = get_viewport().get_mouse_position()
	mouse_coordinate.x = round((mouse_position.x - _offset) / cell_size)
	mouse_coordinate.y = round((mouse_position.y - _offset) / cell_size)
	if mouse_coordinate == play_coordinate:
		coordinate = mouse_coordinate
		_change_scene()
		
func _change_scene():
	transition.transition_out(path)
	
func set_block():
	blocked = true
	var color : Color = get_node('/root/Game').get_inactive_color()
	self.set_self_modulate(color)

func set_unblock():
	blocked = false
	var color : Color = get_node('/root/Game').get_active_color()
	self.set_self_modulate(color)
