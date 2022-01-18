extends CanvasLayer

var valeurActu = self.transform.x
var TailleMax = self.transform.x
var Est_Vide = false
var oskour = 1
export var perte = 0.05

func _physics_process(delta):
	self.get_child(0).transform.x = valeurActu
	
	if self.get_child(0).transform.x.x <= 0:
		BarreVide()
		while oskour < 2 :
			self.get_tree().get_root().get_child(0).get_node("Joueur").die()
			oskour = oskour + 1
	else :
		valeurActu -= (perte* TailleMax / 100)
		
	
func BarreVide():
	Est_Vide = true
	
func GetBarreVide():
	return Est_Vide

func AddAir(valeur):
	valeurActu += (valeur * TailleMax / 100)
	if valeurActu > TailleMax:
		valeurActu = TailleMax
