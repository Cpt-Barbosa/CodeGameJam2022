extends Node2D

func _notification(what):
	if what == 0:
		self.get_parent().get_node("barreOxy").AddAir(25)
		queue_free()
		
func _get(property):
	if property == "type":
		return "BulleAir"
