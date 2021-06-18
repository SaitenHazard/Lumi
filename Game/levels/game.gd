extends Node2D

export var map_size : Vector2 = Vector2(11,6)
var cell_size : float = 96
var offset : float = cell_size / 2

onready var back = get_node('/root/Game/Back')
onready var transition = get_node('/root/Game/SceneTransitionRect') 
onready var camera = get_node('/root/Game/Camera2D') 

const back_colors : Array = [
	"8f5765",
	"f5a15d",
	"ff9757",
	"5b537d",
	"928fb8",
	"cf968c",
	]
	
const active_colors : Array = [
	"cf968c",
	"d46453",
	"d46453",
	"928fb8",
	"5b537d",
	"f0c297",
	]
	
const inactive_colors : Array = [
	"52294b",
	"9c3247",
	"9c3247",
	"392946",
	"392946",
	"8f5765",
	]

var color_index : int;

func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	color_index = rng.randi_range(0, back_colors.size()-1)
	_set_back()
	
func get_active_color() -> Color:
	return active_colors[color_index]
	
func get_inactive_color() -> Color:
	return inactive_colors[color_index]

func _set_back():
	var color = back_colors[color_index]
	color = back_colors[color_index]
	back.set_self_modulate(color)
	back.set_z_index(-3000)
	back.set_position(Vector2(528, 288))
	camera.set_position(Vector2(528, 288))
	camera.current = true
	transition.transition_in(color)

func get_mapsize() -> Vector2:
	return map_size

func get_positon_offset() -> float:
	return offset
	
func get_cell_size() -> float:
	return cell_size
