extends Node2D
@onready var tennis_ball: Node2D = $"../TennisBall"
var basespeed = 120
var direction = 0
var normal = basespeed
var slow = normal / 2
var current = normal
var difficultyindex = 0
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var tt_meter: TextureProgressBar = $"../CanvasLayer/TTMeter"
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D
var colors = [Color("5affd4"),Color("FFA552"), Color("FF4365"), Color("E0DDCF"), Color("FF0A2F")]
var isSwinging = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.modulate = colors[0]
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
		position.x -= direction * delta * current;
	else:
		sprite.play("idle")

func _on_area_2d_area_entered(area: Area2D) -> void:
	hit()

func hit():
	tt_meter.incrementHits()
	var rng = RandomNumberGenerator.new()
	isSwinging = true
	audio.play()
	sprite.play("hit")
	tennis_ball.vdirection = -1
	tennis_ball.hdirection = rng.randf_range(-0.3, 0.3)

func difficultyreset():
	normal = basespeed
	difficultyindex=0
	sprite.modulate = colors[difficultyindex]

func difficultyup():
	normal += 30
	difficultyindex += 1
	if(difficultyindex >= 5):
		difficultyindex = 0
	sprite.modulate = colors[difficultyindex]

func _on_animated_sprite_2d_animation_finished() -> void:
	sprite.play("idle")
	isSwinging = false
