extends TextureProgressBar
@onready var tt_meter: TextureProgressBar = $"."
var hits = 0
var increments = 20
@onready var tennis_ball: Node2D = $"../../TennisBall"
@onready var enemy: Node2D = $"../../Enemy"
var isSlow = false
@onready var time_sfx: AudioStreamPlayer2D = $"../../TimeSFX"
var time_value = 0
@onready var score: Node = $"../../Scoreboxes"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	time_value = 0
	tt_meter.value = time_value

func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("time dive") && tt_meter.value == 100 && !isSlow):
		time_sfx.stream = load("res://assets/sound/timedown.wav")
		time_sfx.play()
		enemy.current = enemy.slow
		tennis_ball.current = tennis_ball.slow
		isSlow = true


func incrementHits():
	if(isSlow):
		return
	hits += 1
	if(hits % 2 > 0 && hits >=2 && time_value < 100):
		time_value += increments
		score.updateuserscore(10)
		if(time_value > 100):
			time_value = 100
		tt_meter.value = time_value

func reset():
	hits = 0
	timeresume()

func timeresume():
	isSlow = false
	enemy.current = enemy.normal
	tennis_ball.current = tennis_ball.normal
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(isSlow):
		time_value -= 20 * delta
		tt_meter.value = time_value
		if(time_value <= 0):
			time_sfx.stream = load("res://assets/sound/timeup.wav")
			time_sfx.play()
			timeresume()
	
