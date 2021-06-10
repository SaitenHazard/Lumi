extends Node2D

onready var TILES = get_node('/root/Game/Tiles')
onready var CONTROL = get_node('/root/Game/CanvasLayer/UI')
onready var TRANSITION = get_node('/root/Game/SceneTransitionRect')

onready var redirects
onready var sources
onready var filters
onready var goals
onready var combiners 
onready var blocks 

var cell_selected : Texture
export var next_level : String

onready var path = "res://levels/level_"+str(next_level)+".tscn"

var SAVE_DIR = "user://saves/"
var save_path = SAVE_DIR + "save.dat"

func _ready():
	_initialize_redirects()
	_initialize_sources()
	_initialize_filters()
	_initialize_goals()
	_initialize_combiners()
	_initialize_blocks()
	replace_lights_all()
	
func _process(delta):
	if _are_all_goals_open():
		_save()
		TRANSITION.transition_out(path)
		
func _save() -> void:
	var last_unlock = _check_last_unlock()
	
	if last_unlock >= next_level:
		return
	
	var data = {
		"level" : next_level
	}
	
	var dir = Directory.new()
	if !dir.dir_exists(SAVE_DIR):
		dir.make_dir_recursive(SAVE_DIR)
	
	var file = File.new()
	var error = file.open_encrypted_with_pass(save_path, File.WRITE, "PASS")
	if error == OK:
		file.store_var(data)
		file.close()
		
func _check_last_unlock() -> int:
	var file = File.new()
	if file.file_exists(save_path):
		var error = file.open_encrypted_with_pass(save_path, File.READ, "PASS")
		if error == OK:
			var player_data = file.get_var()
			return player_data['level']
	return 1

func _are_all_goals_open() -> bool:
	for i in range(goals.size()):
		if goals[i].is_open() == false:
			return false
			
	return true

func _initialize_redirects() -> void:
	redirects = get_node_or_null('Redirects')
	if redirects !=null:
		redirects = redirects.get_children()
		
func _initialize_blocks() -> void:
	blocks = get_node_or_null('Blocks')
	if blocks !=null:
		blocks = blocks.get_children()

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
	var object = get_block(coordinate)
	if object!=null && object.get_being_dragged() == false:
		return object 
	object = _get_redirect(coordinate)
	if object!=null && object.get_being_dragged() == false:
		return object 
	object = _get_source(coordinate)
	if object!=null && object.get_being_dragged() == false:
		return object
	object = _get_filter(coordinate)
	if object!=null && object.get_being_dragged() == false:
		return object 
	object = get_goal(coordinate)
	if object!=null && object.get_being_dragged() == false:
		return object
	object = _get_combiner(coordinate)
	if object!=null && object.get_being_dragged() == false:
		return object
	return null

func get_block(var coordinate : Vector2):
	if blocks != null:
		for i in range(blocks.size()):
			if blocks[i] != null:
				if blocks[i].get_coordinate() == coordinate:
					return blocks[i]
	return null

func _get_redirect(var coordinate : Vector2):
	if redirects != null:
		for i in range(redirects.size()):
			if redirects[i].get_coordinate() == coordinate:
				return redirects[i]
	return null
	
func _get_combiner(var coordinate : Vector2):
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

func _get_source(var coordinate : Vector2):
	if sources != null:
		for i in range(sources.size()):
			if sources[i].get_coordinate() == coordinate:
				return sources[i]
	return null

func get_goal(var coordinate : Vector2):
	if goals != null:
		for i in range(goals.size()):
			if(goals[i].get_coordinate() == coordinate):
				return goals[i]
	return null
