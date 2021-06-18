extends ColorRect

onready var SOUNDS = get_node('/root/Game/Sounds')

onready var _anim_player := $AnimationPlayer

var transition_out : bool = false
var path

func transition_in(var color) -> void:
	transition_out = false
	SOUNDS.get_node('Transition').play()
	self.set_self_modulate(color)
	_anim_player.play_backwards("fade")
	
func transition_out(var m_path) -> void:
	transition_out = true
	path = m_path
	_anim_player.play("fade")

func _on_AnimationPlayer_animation_finished(anim_name):
	if transition_out:
		_change_scene()

func _change_scene():
	var loadscene = load(path)
	get_tree().change_scene(path)
