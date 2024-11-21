extends Node
var playerscore = 0
var enemyscore = 0
var playersets = 0
var enemysets = 0
var gameover = false
var scoretable = [0, 15, 30, 40]
@onready var scoretext: RichTextLabel = $"../CanvasLayer/Label"
@onready var tennis_ball: Node2D = $"../TennisBall"
@onready var tt_meter: TextureProgressBar = $"../CanvasLayer/TTMeter"
@onready var sets: RichTextLabel = $"../CanvasLayer/Sets"
@onready var game: Node2D = $"../.."
@onready var score_sfx: AudioStreamPlayer2D = $"../ScoreSFX"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scoreupdater()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func scoreupdater():
	tt_meter.reset()
	tennis_ball.reset()
	if(playerscore >= 4):
		playerscore = 0
		enemyscore = 0
		playersets +=1
	elif(enemyscore >= 4):
		playerscore = 0
		enemyscore = 0
		enemysets += 1
	updatetext()
	if(enemysets >= 2):
		score_sfx.stream = load("res://assets/sound/gameover.wav")
		score_sfx.play()
		gameover = true
	elif(playersets >= 2):
		print("game over! player won!")

func _on_enemy_area_area_entered(area: Area2D) -> void:
	score_sfx.stream = load("res://assets/sound/playerscore.wav")
	score_sfx.play()
	playerscore += 1
	scoreupdater()

func reset():
	tt_meter.value = 0
	enemysets = 0
	playersets = 0
	updatetext()
func _on_player_area_area_entered(area: Area2D) -> void:
	score_sfx.stream = load("res://assets/sound/enemyscore.wav")
	score_sfx.play()
	enemyscore +=1
	scoreupdater()

func updatetext():
	scoretext.text = ("SCORE " + "[color=#ffea3a]" + str(scoretable[playerscore]) + "[/color] - [color=#5affd4]" + str(scoretable[enemyscore]) + "[/color]")
	sets.text = ("[right]" + "[color=#ffea3a]" + str(playersets) + "[/color] - [color=#5affd4]" + str(enemysets) + "[/color]" + " SETS" + "[/right]")

func _on_score_sfx_finished() -> void:
	if(gameover):
		gameover = false
		reset()
		game.setActive(true)
