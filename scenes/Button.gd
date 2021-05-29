extends Button

export var scene_name : String;

func _on_Button_pressed():
	get_tree().change_scene("res://scenes/Door.tscn")

func disable():
	self.visible = false

func enable():
	self.visible = true
