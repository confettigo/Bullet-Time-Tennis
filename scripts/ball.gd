extends Node2D
var normal = 200
var slow = normal / 2
var current = normal
var hdirection = 0
var vdirection = 0;
var resetposition;
var serving = true
var pathtimer = 0
var ispathing = false
#@onready var line_2d: Line2D = $Line2D
@onready var path_2d: Path2D = $"../Path2D"


# -1 = left, 0, center, 1 = right
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resetposition = position

func reset():
	serving = true
	position = resetposition
	hdirection = 0
	vdirection = 0

#@export var length = 20
#var point = Vector2()


func _input(event: InputEvent) -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#line_2d.global_position = Vector2(0,0)
	#line_2d.global_rotation = 0
	#point = line_2d.get_parent().global_position
	#line_2d.add_point(point)
	#while line_2d.get_point_count()>length:
		#line_2d.remove_point(0)
	
	#position.x += hdirection * current * delta
	#position.y -= vdirection * current * delta
	
	if(!ispathing):
		return
	pathtimer += delta * 0.75
	if(pathtimer >= 1):
		pathtimer = 1
		ispathing = false
	
	position = path_2d.curve.sample(0,pathtimer)
	
	pass
