extends Node
var playerscore = 0
var enemyscore = 0
var scoretable = [0, 15, 30, 40]
@onready var scoretext: RichTextLabel = $"../CanvasLayer/Label"
@onready var tennis_ball: Node2D = $"../TennisBall"
@onready var tt_meter: ProgressBar = $"../CanvasLayer/TTMeter"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scoreupdater()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func scoreupdater():
	tt_meter.reset()
	tennis_ball.reset()
	if(playerscore >= 4 || enemyscore >=4):
		playerscore = 0
		enemyscore = 0
		#print("game over! someone won")
	scoretext.text = ("[color=#ffea3a]" + str(scoretable[playerscore]) + "[/color] - [color=#5affd4]" + str(scoretable[enemyscore]) + "[/color]")
	#scoretext.text = str(scoretable[playerscore]) + " - " + str(scoretable[enemyscore])

func _on_enemy_area_area_entered(area: Area2D) -> void:
	playerscore += 1
	scoreupdater()



func _on_player_area_area_entered(area: Area2D) -> void:
	enemyscore +=1
	scoreupdater()
