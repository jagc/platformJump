extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "_on_body_entered")
	pass

func _on_body_entered(body):
	if body.name == "player":
		if body.position.y <= position.y:
			body.jump()