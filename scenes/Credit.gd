extends Node2D


var state_machine


# Called when the node enters the scene tree for the first time.
func _ready():
	state_machine = $AnimationTree.get("parameters/playback")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ReturnMainButton_pressed():
	self.get_tree().change_scene("res://scenes/MainMenu.tscn")
