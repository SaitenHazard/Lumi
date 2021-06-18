extends Node2D

onready var TRANSITION = get_node('/root/Game/SceneTransitionRect')

func _ready():
	yield(get_tree().create_timer(4.0), "timeout")
	TRANSITION.transition_out("res://levels/level_select.tscn")


