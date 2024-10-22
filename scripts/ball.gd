extends Node2D
var speed = 200
var hdirection = 0
var vdirection = 0;
var resetposition;
var serving = true
# -1 = left, 0, center, 1 = right
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resetposition = position

func reset():
	serving = true
	position = resetposition
	hdirection = 0
	vdirection = 0

func _input(event: InputEvent) -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += hdirection * speed * delta
	position.y -= vdirection * speed * delta
	pass
