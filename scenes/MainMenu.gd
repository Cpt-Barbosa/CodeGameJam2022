extends Panel

func _on_StartButton_pressed():
	self.get_tree().change_scene("res://scenes/Menu Intermédiaire.tscn")


func _on_QuitButton_pressed():
	self.get_tree().quit()
