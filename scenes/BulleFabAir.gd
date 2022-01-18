extends Area2D

func _get(property):
	if property == "type":
		return "BulleFabAir"

func _on_BulleAir_body_entered(body):
	if body.get("type") == "Joueur":
		self.get_parent().get_node("barreOxy").AddAir(25)
		self.get_tree().get_root().get_child(0).get_node("FabriqueDAir").hasBulle=false
		queue_free()
