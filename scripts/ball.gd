extends Node2D
var speed = 200
var hdirection = 0
var vdirection = 0;
var resetposition;
var serving = true
#@onready var line_2d: Line2D = $Line2D


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
	
	position.x += hdirection * speed * delta
	position.y -= vdirection * speed * delta
	pass
