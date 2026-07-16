extends Node2D
## The game loop: spawn fallers, ramp difficulty, score, game over.

const PICKUP_CHANCE := 0.35
const SURVIVAL_POINTS_PER_SECOND := 10.0
const BUBBLE_POINTS := 25
const START_FALL_SPEED := 240.0
const START_SPAWN_WAIT := 0.9
const MIN_SPAWN_WAIT := 0.35
const RAMP_PER_SECOND := 4.0

var game_over := false
var _restart_armed := false
var _elapsed := 0.0
var _score_accum := 0.0

@onready var spawn_timer: Timer = $SpawnTimer
@onready var score_label: Label = $HUD/ScoreLabel
@onready var game_over_label: Label = $HUD/GameOverLabel


func _ready() -> void:
	GameState.reset_run()
	game_over_label.visible = false
	spawn_timer.wait_time = START_SPAWN_WAIT
	spawn_timer.timeout.connect(_spawn_faller)


func _process(delta: float) -> void:
	if game_over:
		# A held key must not skip the funeral: wait for the death
		# screen, then require a FRESH press (release first).
		if not game_over_label.visible:
			return
		if not _restart_armed:
			_restart_armed = not Input.is_anything_pressed()
		elif Input.is_anything_pressed():
			get_tree().reload_current_scene()
		return

	_elapsed += delta
	# Survival trickle: pool fractional points each frame, bank whole ones.
	# (The fix for the heist: int(delta * 10) rounded down to zero every
	# frame — an accumulator keeps the fractions until they add up.)
	_score_accum += delta * SURVIVAL_POINTS_PER_SECOND
	if _score_accum >= 1.0:
		GameState.add_score(int(_score_accum))
		_score_accum -= float(int(_score_accum))
	spawn_timer.wait_time = maxf(MIN_SPAWN_WAIT, START_SPAWN_WAIT - _elapsed * 0.01)

	score_label.text = "Score: %d" % GameState.score


func _spawn_faller() -> void:
	if game_over:
		return
	var kind := Faller.Kind.PICKUP if randf() < PICKUP_CHANCE else Faller.Kind.HAZARD
	var speed := START_FALL_SPEED + _elapsed * RAMP_PER_SECOND
	var faller := Faller.new(kind, speed * randf_range(0.85, 1.15))
	faller.position = Vector2(randf_range(40.0, get_viewport_rect().size.x - 40.0), -60.0)
	faller.hit_player.connect(_on_faller_hit_player)
	add_child(faller)


func _on_faller_hit_player(kind: Faller.Kind, faller: Faller) -> void:
	if kind == Faller.Kind.PICKUP:
		GameState.add_score(BUBBLE_POINTS)
		faller.queue_free()
	else:
		_end_run()


func _end_run() -> void:
	game_over = true
	spawn_timer.stop()
	game_over_label.text = "CLOGGED!\nScore: %d\n\npress any key to re-flush" % GameState.score
	game_over_label.visible = true
