extends CanvasLayer

var valeurActu = self.transform.x
var TailleMax = self.transform.x
var Est_Vide = false
export var perte = 0.05

func _physics_process(delta):
	valeurActu -= (perte* TailleMax / 100)
	self.get_child(0).transform.x = valeurActu
	
	if self.get_child(0).transform.x.x <= 0:
		BarreVide()
		self.get_tree().change_scene("res://scenes/MenuMort.tscn")
	
func BarreVide():
	Est_Vide = true
	
func GetBarreVide():
	return Est_Vide

func AddAir(valeur):
	valeurActu += (valeur * TailleMax / 100)
	if valeurActu > TailleMax:
		valeurActu = TailleMax
