extends StaticBody2D
@onready var player: CharacterBody2D = $"../Player"
@onready var a: Node2D = $"../Clamps/A"
@onready var b: Node2D = $"../Clamps/B"
@onready var enemy: Node2D = $"../Enemy"
@onready var score: Node = $"../Scoreboxes"

#IMPORTANT READ THIS !!!!
#Make path2d to hit ball for enemy (see player)
#Freeze player upon game over


#func _input(event: InputEvent) -> void:
	#if(event.is_action_pressed("time dive")):
		#enemy.speed = 120
	#if(event.is_action_pressed("hit")):
		#score.win = true
		#score._on_score_sfx_finished()

#func _process(delta: float) -> void:
	#queue_redraw()
#
#func _draw():
	#draw_line(a.global_position, player.global_position, Color.CRIMSON, 2)
	#draw_line(b.global_position, player.global_position, Color.CRIMSON, 2)
