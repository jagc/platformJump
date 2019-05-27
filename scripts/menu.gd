extends Node

onready var highscore = $highScore
var volume_db = -33
var pitch_scale = 2
var bgSound = audioManager.play("gameBgMusic", {volume_db = volume_db, pitch_scale = pitch_scale})

func _ready():
	levelManager.current_scene_name = self.get_name()
	var highscore_value = str(playerData.load_highscore())
	highscore.bbcode_text = "[center]"+ highscore_value +"[/center]"

func _on_Button_pressed():
	_change_scene()

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		_change_scene()

func _change_scene():
	var volume_db = 10
	var pitch_scale = 3
	audioManager.play("confirmButton", {volume_db = volume_db, pitch_scale = pitch_scale})
	
	bgSound.stop()
	
	levelManager.change_scene("game")
#	$"/root/levelManager".change_scene("game") # alternative way of using a singleton