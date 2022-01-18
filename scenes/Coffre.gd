extends RigidBody2D

func _notification(what):
	if what == 0:
		queue_free()
		
func _get(property):
	if property == "type":
		return "Coffre"

