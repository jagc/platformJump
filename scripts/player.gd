extends KinematicBody2D

onready var animated_sprite = $AnimatedSprite

const GRAVITY = 1500
const GRAVITY_INCREMENT = 2500
const JUMP_DECREMENT = 100
const JUMP_FORCE = 50

export var speed = 500

var screen_width
var screen_height
var half_sprite_width

var jumping = false
var current_jump_force = 0
var current_gravity = 0
var highest_reached_position = 300
var death_position_offset = 1200
var score = 0

func _ready():
	screen_width = get_viewport_rect().size.x
	screen_height = get_viewport_rect().size.y
	half_sprite_width = animated_sprite.frames.get_frame("idle", 0).get_width() / 2
	current_gravity = GRAVITY

func _process(delta):
	_process_jumping(delta)
		
	highest_reached_position = position.y if position.y < highest_reached_position else highest_reached_position
	
	_process_score()
	
	_process_death()
	
	_process_input(delta)
	
	_process_screen_boundary_checks()

func _process_jumping(delta):
	if !jumping:
		_increment_gravity(delta)
		position.y += current_gravity * delta
	else:
		position.y -= current_jump_force
		_decrement_jump(delta)

func _process_score():
	score = int(abs(highest_reached_position) - 300)
	score = score if score > 0 else 0

func _process_death():
	if position.y >= highest_reached_position + death_position_offset:
		die()

func _process_input(delta):
	if Input.is_action_pressed("ui_left"):
		position.x -= speed * delta
	elif Input.is_action_pressed("ui_right"):
		position.x += speed * delta
	elif Input.is_action_pressed("ui_accept"):
		jump()

func _process_screen_boundary_checks():
	if position.x > screen_width:
		position.x = 0
	elif position.x <= 0:
		position.x = screen_width

func jump():
	if jumping:
		return
	_set_jump_vars(JUMP_FORCE)

func add_impulse(impulse):
	_set_jump_vars(impulse)
	
func _set_jump_vars(force):
	current_gravity = 0
	jumping = true
	current_jump_force = force
	animated_sprite.play("jump")
	
func die():
	playerData.save_highscore(score)
	levelManager.change_scene("menu")

func _increment_gravity(delta):
	current_gravity += GRAVITY_INCREMENT * delta
	if current_gravity >= GRAVITY:
		current_gravity = GRAVITY

func _decrement_jump(delta):
	current_jump_force -= JUMP_DECREMENT * delta
	if current_jump_force <= 0:
		current_jump_force = 0
		jumping = false
		animated_sprite.play("idle")