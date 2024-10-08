extends Area2D
var speed = 0
var direction = 0;
@onready var animation_player: AnimationPlayer = $AnimationPlayer


# -1 = left, 0, center, 1 = right
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
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

func move():
	match direction:
		0:
			animation_player.play("centershot")
		1:
			#right
			animation_player.play("rightshot")
		-1:
			#left
			animation_player.play("leftshot")
	pass
