extends Node

onready var highscore = $highScore

func _ready():
	var highscore_value = str(playerData.load_highscore())
	highscore.bbcode_text = "[center]"+ highscore_value +"[/center]"

func _on_Button_pressed():
	_change_scene()

func _on_Button_gui_input(event):
	if event.is_action_pressed("ui_accept"):
		_change_scene()

func _change_scene():
	$"/root/levelManager".change_scene("game")