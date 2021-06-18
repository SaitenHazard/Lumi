extends Node2D

export var map_size : Vector2 = Vector2(11,6)
var cell_size : float = 96
var offset : float = cell_size / 2

var SAVE_DIR = "user://saves/"
var save_path = SAVE_DIR + "save.dat"

onready var levels = get_children()
onready var IMMOVABLE = load("res://scenes/Immovable.tscn")

func _ready():
	call_deferred('_unlock_levels')

func _unlock_levels():
	var file = File.new()
	if file.file_exists(save_path):
		var error = file.open_encrypted_with_pass(save_path, File.READ, "PASS")
		if error == OK:
			var player_data = file.get_var()
			_lock_level(int(player_data['level']))
			if int(player_data['level']) == 18:
				_do_special_title()
			return
	else:
		_lock_level(1)

func _lock_level(var level_unlocked : int):
	for i in range(0, levels.size()):
		if i > level_unlocked - 1:
			levels[i].set_block()
		else:
			levels[i].set_unblock()

func _do_special_title():
	yield(get_tree().create_timer(2.5), "timeout")
	get_node('/root/Game/Light_blue/AnimationPlayer').play('beam');
	get_node('/root/Game/Light_red/AnimationPlayer').play('beam');
