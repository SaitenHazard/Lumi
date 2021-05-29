extends Node2D

onready var mirrors : Array
onready var guns : Array
onready var filters : Array

func _ready():
	_initialize_mirrors()
	_initialize_guns()
	_initialize_filters()
	replace_lights_all()

func _initialize_mirrors() -> void:
	mirrors = get_node('Mirrors').get_children()
	
func _initialize_guns() -> void:
	guns = get_node('Guns').get_children()
	
func _initialize_filters() -> void:
	filters = get_node('Filters').get_children()

func replace_lights_all() -> void:
	deplace_lights_all()
	place_lights_guns()

func deplace_lights_all()->void:
	deplace_lights_guns()
	deplace_lights_filters()
	deplace_lights_mirrors()
	
func place_lights_guns() -> void:
	for i in (guns.size()):
		guns[i].place_lights(null)

func deplace_lights_guns() -> void:
	for i in (guns.size()):
		guns[i].deplace_lights()

func deplace_lights_filters() -> void:
	for i in (filters.size()):
		filters[i].deplace_lights()
		
func deplace_lights_mirrors() -> void:
	for i in (mirrors.size()):
		mirrors[i].deplace_lights()

func get_interaction_object(var coordinate : Vector2) -> Sprite:
	var object : Sprite = _get_mirror(coordinate)
	if object!=null && object.get_being_dragged() == false:
		return object
	object = _get_gun(coordinate)
	if object!=null && object.get_being_dragged() == false:
		return object
	object = _get_filters(coordinate)
	if object!=null && object.get_being_dragged() == false:
		return object 
	return null
	

func _get_mirror(var coordinate : Vector2):
	for i in range(mirrors.size()):
		if(mirrors[i].get_coordinate() == coordinate):
			return mirrors[i]
	return null

func _get_filters(var coordinate : Vector2):
	for i in range(filters.size()):
		if(filters[i].get_coordinate() == coordinate):
			return filters[i]
	return null

func _get_gun(var coordinate : Vector2):
	for i in range(guns.size()):
		if(guns[i].get_coordinate() == coordinate):
			return guns[i]
	return null
