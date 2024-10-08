extends Area2D
var speed = 0
var direction = 0;
var bdirection = 0
var vdirection = 0;
var t = 0;
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $"../Timer"
@onready var parent: Node2D = $".."


# -1 = left, 0, center, 1 = right
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	parent.position.x += 1 * speed * bdirection
	parent.position.y -= 1 * speed * vdirection
	pass

func _input(event):
	if event.is_action_pressed("moveleft") || event.is_action_pressed("moveright"):
		if event.is_action_pressed("moveleft"):
			direction = -1;
		elif event.is_action_pressed("moveright"):
			direction = 1;
	elif (event.is_action_released("moveleft") || event.is_action_released("moveright")):
		direction = 0

func _on_area_entered(area: Area2D) -> void:
	if(area.get_parent().name == "RacketBox"):
		move()
	elif(area.get_parent().name == "Enemy"):
		vdirection = -1

func move():
	bdirection = direction
	vdirection = 1
	speed = 0.9
	#timer.start()


func _on_timer_timeout() -> void:
	vdirection = 0
	speed = 0
	pass # Replace with function body.
