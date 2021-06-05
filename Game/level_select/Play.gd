extends Sprite

onready var GAME = get_node('/root/Game/')

onready var size : Vector2 = GAME.get_mapsize()

export var coordinate : Vector2 = Vector2(5,5)

var _offset : float 
var cell_size : float

func get_coordinate() -> Vector2:
	return coordinate

func _ready() -> void:
	_initialize()
	_set_position()

func _initialize() -> void:
	_offset = GAME.get_positon_offset()
	cell_size = GAME.get_cell_size()
	
func _set_position():
	self.position = Vector2(
		_offset + coordinate.x * cell_size, _offset + coordinate.y * cell_size)
