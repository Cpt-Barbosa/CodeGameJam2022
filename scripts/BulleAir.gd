extends Area2D

func _get(property):
	if property == "type":
		return "BulleAir"

func _on_BulleAir_body_entered(body):
	if body.get("type") == "Joueur":
		$Plop.play()
		self.get_parent().get_node("barreOxy").AddAir(25)
		queue_free()
	
