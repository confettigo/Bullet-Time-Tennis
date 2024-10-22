extends Node
var playerscore = 0
var enemyscore = 0
var scoretable = [0, 15, 30, 40]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func scoreupdater():
	if(playerscore >= 4 || enemyscore >=4):
		playerscore = 0
		enemyscore = 0
		print("game over! someone won")
	print("PLAYER - " + str(scoretable[playerscore]))
	print("ENEMY - " + str(scoretable[enemyscore]))

func _on_enemy_area_area_entered(area: Area2D) -> void:
	print("player scored!")
	playerscore += 1
	scoreupdater()



func _on_player_area_area_entered(area: Area2D) -> void:
	print("enemy scored!")
	enemyscore +=1
	scoreupdater()
