extends Node2D
@onready var tennis_ball: Node2D = $"../TennisBall"
var direction = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(position.x < tennis_ball.position.x):
		direction = -1
	else:
		direction = 1
	if(position.x != tennis_ball.position.x):
		position.x -= 1 * direction;
	pass

func _on_area_2d_area_entered(area: Area2D) -> void:
	tennis_ball.vdirection = -1
	tennis_ball.hdirection = 0
	hit()

func hit():
	pass
