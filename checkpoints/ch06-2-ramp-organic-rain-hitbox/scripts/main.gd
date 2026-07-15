extends Node2D
## The game loop: spawn plungers, ramp the meanness, handle death.

const START_FALL_SPEED := 240.0
const START_SPAWN_WAIT := 0.9
const MIN_SPAWN_WAIT := 0.35
const RAMP_PER_SECOND := 4.0   # fall speed gained per second survived

var game_over := false
var _elapsed := 0.0

@onready var spawn_timer: Timer = $SpawnTimer
@onready var game_over_label: Label = $HUD/GameOverLabel


func _ready() -> void:
	game_over_label.visible = false
	spawn_timer.wait_time = START_SPAWN_WAIT
	spawn_timer.timeout.connect(_spawn_faller)


func _process(delta: float) -> void:
	if game_over:
		if Input.is_anything_pressed():
			get_tree().reload_current_scene()
		return

	_elapsed += delta
	spawn_timer.wait_time = maxf(MIN_SPAWN_WAIT, START_SPAWN_WAIT - _elapsed * 0.01)


func _spawn_faller() -> void:
	if game_over:
		return
	var speed := START_FALL_SPEED + _elapsed * RAMP_PER_SECOND
	var faller := Faller.new(speed * randf_range(0.85, 1.15))
	faller.position = Vector2(randf_range(40.0, get_viewport_rect().size.x - 40.0), -60.0)
	faller.hit_player.connect(_on_faller_hit_player)
	add_child(faller)


func _on_faller_hit_player(_faller: Faller) -> void:
	game_over = true
	spawn_timer.stop()
	game_over_label.text = "CLOGGED!\n\npress any key to re-flush"
	game_over_label.visible = true
