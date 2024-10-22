extends Node2D
@onready var tennis_ball: Node2D = $"../TennisBall"
var direction = 0
var speed = 120
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
var isSwinging = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(isSwinging):
		return
	if(tennis_ball.serving):
		sprite.play("idle")
		position.x = 0
	
	if(position.x < tennis_ball.position.x):
		direction = -1
	else:
		direction = 1
	if(abs(position.x - tennis_ball.position.x) >= 0.75):
		
		sprite.play("walking")
		position.x -= direction * delta * speed;
	else:
		sprite.play("idle")

func _on_area_2d_area_entered(area: Area2D) -> void:
	var rng = RandomNumberGenerator.new()
	isSwinging = true
	sprite.play("hit")
	tennis_ball.vdirection = -1
	tennis_ball.hdirection = rng.randf_range(-0.3, 0.3)
	hit()

func hit():
	
	pass


func _on_animated_sprite_2d_animation_finished() -> void:
	sprite.play("idle")
	isSwinging = false
