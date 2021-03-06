extends Path2D

export var speed = 250

onready var follow = $follow
onready var platform = $follow/platform

var direction = 1 #is it moving left or right?
var sprite_half_width

signal just_exited

func _ready():
	randomize()
	direction = 1 if rand_range(0, 100) > 50 else -1
	sprite_half_width = platform.sprite_half_width

func _process(delta):
	follow.offset += speed * direction * delta
	if direction > 0 and follow.unit_offset > 0.99:
		direction = -1
	elif direction < 0 and follow.unit_offset < 0.01:
		direction = 1


func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("just_exited")
	self.queue_free()