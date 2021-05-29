extends Node2D

onready var TILE = preload("res://scenes/tile.tscn")

export var map_size : Vector2 = Vector2(11,6)
var cell_size : float = 96
var offset : float = cell_size / 2

func _ready() -> void:
	call_deferred("_set_tiles")

func _set_tiles() -> void:
	for i in range(map_size.x):
		for j in range(map_size.y):
			var tile =  TILE.instance()
			get_node('/root/Game/ObjectManager').add_child(tile)
			tile.position = Vector2(
				offset + (i*cell_size), offset + (j*cell_size))

func get_mapsize() -> Vector2:
	return map_size

func get_positon_offset() -> float:
	return offset
	
func get_cell_size() -> float:
	return cell_size
