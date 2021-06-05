extends Node2D

export var map_size : Vector2 = Vector2(11,6)
var cell_size : float = 96
var offset : float = cell_size / 2

onready var back = get_node('/root/Game/Back')
onready var transition = get_node('/root/Game/SceneTransitionRect') 

const back_colors : Array = [
	"8f5765",
	"d46453",
	"f5a15d",
	"ff9757",
	"5b537d",
	"928fb8",
	"cf968c",
	]

func _ready():
	_set_back()

func _set_back():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var rand = rng.randi_range(0, back_colors.size()-1)
	var color = back_colors[rand]
	back.set_self_modulate(color)
	back.set_z_index(-3000)
	transition.transition_in(color)

func get_mapsize() -> Vector2:
	return map_size

func get_positon_offset() -> float:
	return offset
	
func get_cell_size() -> float:
	return cell_size
