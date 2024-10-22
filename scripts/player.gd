extends CharacterBody2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var tennis_ball: Node2D = $"../TennisBall"
var hitbox = load("res://scenes/racket_box.tscn")
@onready var a: Node2D = $"../Clamps/A"
@onready var b: Node2D = $"../Clamps/B"


const SPEED = 80.0
var lastdirection = -1
var isIdle = false
var isSwinging = false

#func _process(delta: float) -> void:
	#queue_redraw()
#
#func _draw():
	#draw_line(a.global_position, global_position, Color.CRIMSON, 2)
	#draw_line(b.global_position, global_position, Color.CRIMSON, 2)

func _physics_process(delta: float) -> void:
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
	tennis_ball.serving = false
	isSwinging = true
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
	balldirection = balldirection.normalized()
	queue_redraw()
	tennis_ball.hdirection = -balldirection.x
	tennis_ball.vdirection = balldirection.y


func _on_animated_sprite_2d_animation_finished() -> void:
	sprite.play("idleleft")
	isSwinging = false
