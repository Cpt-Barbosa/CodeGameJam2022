extends Area2D



func _on_changement_de_niveau_area_entered(area):
	self.get_tree().change_scene("res://scenes/Game.tscn")
