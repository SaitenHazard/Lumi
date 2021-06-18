extends Sprite

export var color : String
export var coordinate : Vector2 = Vector2(5,5)

onready var OBJECTMANAGER = get_node('/root/Game/ObjectManager')
onready var GAME = get_node('/root/Game/')
onready var SOUNDS = get_node('/root/Game/Sounds')

var _offset : float
var cell_size : float

var destroyed = false;

func _ready():
	texture = load("res://sprites/block/block_"+color+".png")
	_initialize()
	_set_position()

func _initialize() -> void:
	_offset = GAME.get_positon_offset()
	cell_size = GAME.get_cell_size()
	
func get_coordinate() -> Vector2:
	if destroyed:
		return Vector2(-1,-1)
	return coordinate

func place_lights(var light_direction, var light_color : String)->void:
	if light_color == color:
		destroyed = true;
		SOUNDS.get_node('Destroy').play()
		get_node("AnimationPlayer").play("explode")
#		queue_free()

func _set_position() -> void :
	self.position = Vector2(_offset + coordinate.x * cell_size, _offset + coordinate.y * cell_size)

func get_being_dragged() -> bool:
	return false
