extends Control

export var scene_name : String;
var path : String;

func _ready():
	path = "res://levels/"+str(scene_name)+".tscn"

func _on_Button_pressed():
	get_tree().change_scene(path)

func disable():
	self.get_node('Button').visible = false

func enable():
	self.get_node('Button').visible = true
