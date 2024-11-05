extends Node2D
@onready var title_screen: Control = $TitleScreen
@onready var game_screen: Node2D = $GameScreen
@onready var canvas_layer: CanvasLayer = $GameScreen/CanvasLayer


var isTitle = true
func _ready() -> void:
	setActive(isTitle)

func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("hit") && isTitle):
		isTitle = false
		setActive(isTitle)

func setActive(state: bool):
	isTitle = state
	title_screen.visible = state
	game_screen.visible = !state
	canvas_layer.visible = !state
