extends CharacterBody2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var tennis_ball: Node2D = $"../TennisBall"
var hitbox = load("res://scenes/racket_box.tscn")
@onready var a: Node2D = $"../Clamps/A"
@onready var b: Node2D = $"../Clamps/B"
@onready var tt_meter: TextureProgressBar = $"../CanvasLayer/TTMeter"
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var path_2d: Path2D = $"../Path2D"
@onready var enemy: Node2D = $"../Enemy"


const SPEED = 80.0
var lastdirection = -1
var isIdle = false
var isSwinging = false
var isFrozen = false

#func _process(delta: float) -> void:
	#queue_redraw()
#
#func _draw():
	#draw_line(a.global_position, global_position, Color.CRIMSON, 2)
	#draw_line(b.global_position, global_position, Color.CRIMSON, 2)

func _physics_process(delta: float) -> void:
	if(isFrozen):
		return
	var hdirection := Input.get_axis("moveleft", "moveright")
	var vdirection := Input.get_axis("movedown","moveup")
	velocity.x = hdirection * SPEED
	velocity.y = -vdirection * SPEED
	
	if(isSwinging):
		pass
	elif(hdirection != 0 || vdirection != 0):
		sprite.play("walkingleft")
	else:
		sprite.play("idleleft")
	
	if(tennis_ball.position.x > position.x && lastdirection > 0):
		sprite.flip_h = 1
		lastdirection = -1
	elif(tennis_ball.position.x < position.x && lastdirection < 0):
		sprite.flip_h = 0
		lastdirection = 1
	
	move_and_slide()



func _on_area_2d_area_entered(area: Area2D) -> void:
	if(isFrozen):
		return
	tt_meter.incrementHits()
	tennis_ball.serving = false
	isSwinging = true
	audio.play()
	sprite.play("swingleft")
	
	var balldirection = -Vector2(tennis_ball.position - position)
	var player_a = -Vector2(a.global_position - position)
	var player_b = -Vector2(b.global_position - position)
	
	var angle_a = player_a.angle()
	var angle_b = player_b.angle()
	var angle_ball = balldirection.angle()
	if(angle_ball < -PI/2 || angle_ball > angle_b):
		balldirection = player_b
	elif(angle_ball > -PI/2 && angle_ball < angle_a):
		balldirection = player_a
	
	
	#var stoppoint = Geometry2D.line_intersects_line(tennis_ball.position,Vector2(-balldirection.x,-balldirection.y),Vector2(enemy.position.x - 100, enemy.position.y), Vector2.RIGHT) 
	#path_2d.curve.set_point_position(0, tennis_ball.position)
	#path_2d.curve.set_point_out(0,Vector2(-balldirection.x,-balldirection.y*1.8))
	#path_2d.curve.set_point_position(1, stoppoint)
	#tennis_ball.ispathing = true
	#path_2d.curve.set_point_in(1,Vector2(1,1) * multiplier)
	balldirection = balldirection.normalized()
	tennis_ball.hdirection = -balldirection.x
	tennis_ball.vdirection = balldirection.y

func freeze():
	sprite.play("idleleft")
	isFrozen = true
func _on_animated_sprite_2d_animation_finished() -> void:
	sprite.play("idleleft")
	isSwinging = false
