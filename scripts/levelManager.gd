extends Node

const SCENE_PATH = "res://scenes/"

var current_scene_name

func change_scene(scene_name):
	deffer_call("_deffered_change_scene", scene_name)

func _deffered_change_scene(scene_name):
	var path = SCENE_PATH + scene_name + ".tscn"
	var root = get_tree().get_root()
	var current = root.get_child(root.get_child_count() - 1)
	current.free()
	var scene_resource = ResourceLoader.load(path)
	var new_scene = scene_resource.instance()
	get_tree().get_root().add_child(new_scene)
	get_tree().set_current_scene(new_scene)
	
func _process(_delta):
	if Input.is_action_pressed("close"):
		if current_scene_name == "menu":
			get_tree().quit()
		elif current_scene_name == "game":
			change_scene("menu")
		
func deffer_call(func_name, func_param):
	call_deferred(func_name, func_param)
	