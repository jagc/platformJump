extends Node

export(Array) var platforms
export(Array) var special_platforms

onready var player = $player
onready var score_text = $ui/score

const MIN_INTERVAL = 100
const MAX_INTERVAL = 250
const INITIAL_PLATFORMS_COUNT = 10

var special_platforms_chance = 0
var current_max_interval
var current_min_interval
var last_spawn_height
var screen_size
var player_score_checkpoint = 1000
var is_player_score_checkpoint = false

func _ready():
	levelManager.current_scene_name = self.get_name()
	last_spawn_height = get_viewport().get_visible_rect().size.y
	current_max_interval = MIN_INTERVAL
	current_min_interval = MIN_INTERVAL
	screen_size = get_viewport().get_visible_rect().size.x
	_spawn_first_platforms()

func _process(_delta):
	score_text.text = str(player.score)

func _spawn_first_platforms():
	for _counter in range(INITIAL_PLATFORMS_COUNT):
		_spawn_caller()

func _spawn_platform():
	randomize()
	var index
	var new_platform
	if rand_range(0, 100) > 100 - special_platforms_chance:
		index = rand_range(0, special_platforms.size())
		new_platform = special_platforms[index].instance()
	else:
		index = rand_range(0, platforms.size())
		new_platform = platforms[index].instance()

	new_platform.connect("just_exited", self, "on_platform_just_exited")
	add_child(new_platform)
	var spawn_x = rand_range(0 + new_platform.sprite_half_width, screen_size - new_platform.sprite_half_width)
	var spawn_position = Vector2(spawn_x, last_spawn_height)
	new_platform.position = spawn_position
	last_spawn_height -= rand_range(current_min_interval, current_max_interval)
	current_min_interval += 5
	current_max_interval += 7.5
	current_max_interval = clamp(current_max_interval, MIN_INTERVAL, MAX_INTERVAL)
	current_min_interval = clamp(current_min_interval, MIN_INTERVAL, MAX_INTERVAL / 0.75)

func on_platform_just_exited():
	if special_platforms_chance == 0:
		special_platforms_chance = 5
	elif special_platforms_chance <= 90:
		if player.score >= player_score_checkpoint:
			is_player_score_checkpoint = true
			player_score_checkpoint += player.score
		else:
			is_player_score_checkpoint = false
		if is_player_score_checkpoint:
			special_platforms_chance += 5
			print('added special platform chance.' + 'plat chance at: ' + str(special_platforms_chance))
		
	_spawn_caller()

func _spawn_caller():
	call_deferred("_spawn_platform")