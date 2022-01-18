extends Popup

var pause = false

func _input(event):
	if Input.is_action_just_pressed("ui_cancel") && !pause:
		pause = true
		get_tree().paused = true
		self.show()
	elif Input.is_action_just_pressed("ui_cancel") && pause:
		pause = false
		self.hide()
		get_tree().paused = false
		
