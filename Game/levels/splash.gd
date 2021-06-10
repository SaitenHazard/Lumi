extends Sprite

onready var _anim_player := $AnimationPlayer

func _ready():
	yield(get_tree().create_timer(1.5), "timeout")
	_fade_out()
	
func _fade_out():
	_anim_player.play_backwards("fade")
