extends Popup

var pause = false
var Easter_Egg = []

func _input(event):
	if Input.is_action_just_pressed("ui_cancel") && !pause:
		pause = true
		get_tree().paused = true
		self.show()
	elif Input.is_action_just_pressed("ui_cancel") && pause:
		pause = false
		self.hide()
		get_tree().paused = false
		
func _physics_process(delta):
	if pause:
		if Input.is_action_just_pressed("ui_down"):
			Easter_Egg.append("down")
		elif Input.is_action_just_pressed("ui_left"):
			Easter_Egg.append("left")
		elif Input.is_action_just_pressed("ui_up"):
			Easter_Egg.append("up")
		elif Input.is_action_just_pressed("ui_right"):
			Easter_Egg.append("right")
		
		if Easter_Egg == ["up","up","down","down","left","right","left","right"]:
			Easter_Egg = []
			print("Easter_Egg")
	else:
		Easter_Egg = []
