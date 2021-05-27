extends Node2D

onready var mirrors : Array
onready var guns : Array

func _ready():
	call_deferred('_initialize_mirrors')
	call_deferred('_initialize_guns')

func _initialize_mirrors() -> Array:
	mirrors = get_node('Mirrors').get_children()
	return mirrors
	
func _initialize_guns() -> Array:
	guns = get_node('Guns').get_children()
	return guns
	
func replace_all_lights():
	for i in range(guns.size()):
		guns[i].replace_lights()
	return null
	
func get_mirror(var coordinate : Vector2):
	for i in range(mirrors.size()):
		if(mirrors[i].get_coordinate() == coordinate):
			return mirrors[i]
	return null
	
func get_gun(var coordinate : Vector2):
	for i in range(guns.size()):
		if(guns[i].get_coordinate() == coordinate):
			return guns[i]
	return null
