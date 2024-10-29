extends ProgressBar
@onready var tt_meter: ProgressBar = $"."
var hits = 0
var increments = 20


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tt_meter.value = 0

func incrementHits():
	hits += 1
	if(hits % 2 > 0 && hits >=2):
		tt_meter.value += increments

func reset():
	hits = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
