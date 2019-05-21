extends Node

func _on_Button_pressed():
	_change_scene()

func _on_Button_gui_input(event):
	if event.is_action_pressed("ui_accept"):
		_change_scene()

func _change_scene():
	$"/root/levelManager".change_scene("game")