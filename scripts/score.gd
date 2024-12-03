extends Node
var playerscore = 0
var enemyscore = 0
var userscore = 0
var playersets = 0
var enemysets = 0
var gameover = false
var win = false
var scoretable = [0, 15, 30, 40]
@onready var scoretext: RichTextLabel = $"../CanvasLayer/Label"
@onready var tennis_ball: Node2D = $"../TennisBall"
@onready var tt_meter: TextureProgressBar = $"../CanvasLayer/TTMeter"
@onready var sets: RichTextLabel = $"../CanvasLayer/Sets"
@onready var game: Node2D = $"../.."
@onready var score_sfx: AudioStreamPlayer2D = $"../ScoreSFX"
@onready var player: CharacterBody2D = $"../Player"
@onready var enemy: Node2D = $"../Enemy"
@onready var userscoretext: RichTextLabel = $"../CanvasLayer/Score"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scoreupdater()
	updateuserscore(0)

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
		updateuserscore(500)
	elif(enemyscore >= 4):
		playerscore = 0
		enemyscore = 0
		enemysets += 1
	updatetext()
	if(enemysets >= 2):
		score_sfx.stream = load("res://assets/sound/gameover.wav")
		score_sfx.play()
		gameover = true
		player.freeze()
	elif(playersets >= 2):
		score_sfx.stream = (load("res://assets/sound/wintheme.wav"))
		updateuserscore(1000)
		score_sfx.play()
		player.freeze()
		win = true


func _on_enemy_area_area_entered(area: Area2D) -> void:
	score_sfx.stream = load("res://assets/sound/playerscore.wav")
	score_sfx.play()
	playerscore += 1
	updateuserscore(100)
	scoreupdater()

func reset():
	player.isFrozen = false
	tt_meter.value = 0
	enemysets = 0
	playersets = 0
	tt_meter.time_value = 0
	updatetext()
func _on_player_area_area_entered(area: Area2D) -> void:
	score_sfx.stream = load("res://assets/sound/enemyscore.wav")
	score_sfx.play()
	enemyscore +=1
	scoreupdater()

func updatetext():
	scoretext.text = ("SCORE " + "[color=#ffea3a]" + str(scoretable[playerscore]) + "[/color] - [color=" + str(enemy.colors[enemy.difficultyindex].to_html(false)) + "]" + str(scoretable[enemyscore]) + "[/color]")
	sets.text = ("[right]" + "[color=#ffea3a]" + str(playersets) + "[/color] - [color=" + str(enemy.colors[enemy.difficultyindex].to_html(false)) + "]" + str(enemysets) + "[/color]" + " SETS" + "[/right]")
func updateuserscore(scoretoadd):
	userscore += scoretoadd
	userscoretext.text = str(userscore)
func _on_score_sfx_finished() -> void:
	if(gameover):
		gameover = false
		userscore = 0
		updateuserscore(0)
		reset()
		enemy.difficultyreset()
		game.setActive(true)
	
	if(win):
		win = false
		reset()
		enemy.difficultyup()
		updatetext()
