extends ProgressBar
@onready var tt_meter: ProgressBar = $"."
var hits = 0
var increments = 20
@onready var tennis_ball: Node2D = $"../../TennisBall"
@onready var enemy: Node2D = $"../../Enemy"
var isSlow = false
@onready var time_sfx: AudioStreamPlayer2D = $"../../TimeSFX"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tt_meter.value = 0

func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("time dive") && tt_meter.value == 100 && !isSlow):
		time_sfx.stream = load("res://assets/sound/timedown.wav")
		time_sfx.play()
		enemy.speed /= 2
		tennis_ball.speed /= 1.5
		isSlow = true


func incrementHits():
	if(isSlow):
		return
	hits += 1
	if(hits % 2 > 0 && hits >=2):
		tt_meter.value += increments

func reset():
	hits = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(isSlow):
		tt_meter.value -= 20 * delta
		if(tt_meter.value <= 0):
			time_sfx.stream = load("res://assets/sound/timeup.wav")
			time_sfx.play()
			isSlow = false
			enemy.speed *= 2
			tennis_ball.speed *= 1.5
	
