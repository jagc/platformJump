extends Area2D

export var impulse = 100

onready var animation = $animation

var height

signal just_exited

func _ready():
	# obtains height of sprite
	height = animation.frames.get_frame("idle", 0).get_height()
	
	var connect = connect("body_entered", self, "_on_body_entered", [], 1)
	if connect != OK:
		printerr('connection failed')
	
func _on_body_entered(body):
	if body.name == "player" and body.position.y < position.y and !body.jumping:
		body.add_impulse(impulse)
		animation.play("spring")

func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("just_exited")
	self.queue_free()
