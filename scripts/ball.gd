extends Node2D
var speed = 200
var hdirection = 0
var vdirection = 0;
var resetposition;

# -1 = left, 0, center, 1 = right
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resetposition = position

func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("time dive")):
		position = resetposition
		hdirection = 0
		vdirection = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += hdirection * speed * delta
	position.y -= vdirection * speed * delta
	pass
