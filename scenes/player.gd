extends CharacterBody2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 60.0
var lastdirection = 0
var isIdle = true

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("moveleft", "moveright")
	var vdirection := Input.get_axis("movedown","moveup")
	velocity.x = direction * SPEED
	velocity.y = -vdirection * SPEED
	
	#animations
	
	if direction < 0 || lastdirection < 0 && vdirection != 0:
		sprite.play("walkingleft")
		lastdirection = -1
		isIdle = false
	elif direction > 0 || lastdirection > 0 && vdirection != 0:
		sprite.play("walkingright")
		lastdirection = 1
		isIdle = false
	else:
		if lastdirection < 0 && !isIdle:
			sprite.play("idleleft")
			isIdle = true
		if lastdirection > 0 && !isIdle:
			sprite.play("idleright")
			isIdle = true

	move_and_slide()

func _input(event):
	if event.is_action_pressed("hit"):
		print(lastdirection)
		if lastdirection <= 0:
			print("swing left")
			sprite.play("swingleft")
		else:
			print("swing right")
			sprite.play("swingright")


func _on_animated_sprite_2d_animation_finished() -> void:
	if sprite.animation == "swingleft":
		sprite.play("afterhitleft")
	elif sprite.animation == "swingright":
		sprite.play("afterhitright")
