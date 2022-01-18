extends Node2D

var TailleMax = self.transform.x
var temps = 0
var Est_Vide = false

func _physics_process(delta):
	self.transform.x = TailleMax - (temps* TailleMax / 100)
	
	if self.transform.x.x > 0:
		temps += 1#0.05
	else:
		BarreVide()
	#print(str(self.transform.x))
	
func BarreVide():
	Est_Vide = true
	
func GetBarreVide():
	return Est_Vide
