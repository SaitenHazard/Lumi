extends Node2D

onready var TILES = get_node('/root/Game/Tiles')
onready var CONTROL = get_node('/root/Game/CanvasLayer/UI')

onready var redirects
onready var sources
onready var filters
onready var goals
onready var combiners 

var cell_selected : Texture

func _ready():
	_initialize_redirects()
	_initialize_sources()
	_initialize_filters()
	_initialize_goals()
	_initialize_combiners()
	replace_lights_all()
	
func _process(delta):
	var b = _are_all_goals_open()
	if b == false:
		CONTROL.disable()
	else:
		CONTROL.enable()
	
func _are_all_goals_open() -> bool:
	for i in range(goals.size()):
		if goals[i].is_open() == false:
			return false
			
	return true

func _initialize_redirects() -> void:
	redirects = get_node_or_null('Redirects')
	if redirects !=null:
		redirects = redirects.get_children()

func _initialize_combiners() -> void:
	combiners = get_node_or_null('Combiners')
	if combiners !=null:
		combiners = combiners.get_children()

func _initialize_filters() -> void:
	filters = get_node_or_null('Filters')
	if filters !=null:
		filters = filters.get_children()
	
func _initialize_sources() -> void:
	sources = get_node_or_null('Sources')
	if sources !=null:
		sources = sources.get_children()
	
func _initialize_goals() -> void:
	goals = get_node_or_null('Goals')
	if goals !=null:
		goals = goals.get_children()

func replace_lights_all() -> void:
	deplace_lights_all()
	place_lights_sources()

func deplace_lights_all()->void:
	deplace_lights_sources()
	deplace_lights_combiners()
	deplace_lights_filters()
	deplace_lights_redirects()
	deplace_lights_goals()

func place_lights_sources() -> void:
	for i in (sources.size()):
		sources[i].place_lights_initial(null, null)

func deplace_lights_combiners() -> void:
	if combiners != null:
		for i in (combiners.size()):
			combiners[i].deplace_lights()

func deplace_lights_sources() -> void:
	if sources != null:
		for i in (sources.size()):
			sources[i].deplace_lights()

func deplace_lights_filters() -> void:
	if filters != null:
		for i in (filters.size()):
			filters[i].deplace_lights()
		
func deplace_lights_redirects() -> void:
	if redirects != null:
		for i in (redirects.size()):
			redirects[i].deplace_lights()
		
func deplace_lights_goals() -> void:
	if goals != null :
		for i in (goals.size()):
			goals[i].deplace_lights()

func get_interaction_object(var coordinate : Vector2) -> Sprite:
	var object = _get_redirects(coordinate)
	if object!=null && object.get_being_dragged() == false:
		return object
	object = _get_sources(coordinate)
	if object!=null && object.get_being_dragged() == false:
		return object
	object = _get_filter(coordinate)
	if object!=null && object.get_being_dragged() == false:
		return object 
	object = get_goals(coordinate)
	if object!=null && object.get_being_dragged() == false:
		return object
	object = _get_combiners(coordinate)
	if object!=null && object.get_being_dragged() == false:
		return object 
	return null
	
func _get_redirects(var coordinate : Vector2):
	if redirects != null:
		for i in range(redirects.size()):
			if redirects[i].get_coordinate() == coordinate:
				return redirects[i]
	return null
	
func _get_combiners(var coordinate : Vector2):
	if combiners != null:
		for i in range(combiners.size()):
			if combiners[i].get_coordinate() == coordinate:
				return combiners[i]
	return null

func _get_filter(var coordinate : Vector2):
	if filters != null:
		for i in range(filters.size()):
			if filters[i].get_coordinate() == coordinate:
				return filters[i]
	return null

func _get_sources(var coordinate : Vector2):
	if sources != null:
		for i in range(sources.size()):
			if sources[i].get_coordinate() == coordinate:
				return sources[i]
	return null

func get_goals(var coordinate : Vector2):
	if goals != null:
		for i in range(goals.size()):
			if(goals[i].get_coordinate() == coordinate):
				return goals[i]
	return null
