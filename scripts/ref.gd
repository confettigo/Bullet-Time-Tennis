extends AnimatedSprite2D
@onready var tennis_ball: Node2D = $"../TennisBall"
enum  state {DOWN, CENTER, UP}
var current_state = state.DOWN


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func up():
	current_state = state.UP
	play("up")

func center():
	current_state = state.CENTER
	play("center")

func down():
	current_state = state.DOWN
	play("down")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(current_state != state.DOWN && tennis_ball.position.y > position.y + 10):
		down()
	if(current_state != state.CENTER && tennis_ball.position.y < position.y + 10 && tennis_ball.position.y > position.y -10):
		center()
	elif(current_state != state.UP && tennis_ball.position.y < position.y - 10):
		up()
	pass
