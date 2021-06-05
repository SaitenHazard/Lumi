extends Sprite

onready var GAME = get_node('/root/Game/')

export var coordinate : Vector2 = Vector2(5,5)

onready var size : Vector2 = GAME.get_mapsize()
onready var max_lights : float = size.x

var being_dragged : bool = false
var _offset : float 
var cell_size : float

func _ready() -> void:
	_initialize()

func _initialize() -> void:
	get_node('Area2D/CollisionShape2D').shape.extents = Vector2(50,50)
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
