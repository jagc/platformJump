extends Area2D

onready var sprite = $Sprite
onready var collision = $collision
onready var particles = $particles

var sprite_half_width

func _ready():
	sprite_half_width = sprite.texture.get_width() / 2
	connect("body_entered", self, "_on_body_entered")
	
func _on_body_entered(body):
	if body.name == "player" and !body.jumping:
		if body.position.y < position.y:
			body.jump()
			sprite.queue_free()
			collision.queue_free()
			particles.emitting = true

func _on_VisibilityNotifier2D_screen_exited():
	self.queue_free()
