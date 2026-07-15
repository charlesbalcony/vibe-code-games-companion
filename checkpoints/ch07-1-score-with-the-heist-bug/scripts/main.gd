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
var _elapsed := 0.0

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
		if Input.is_anything_pressed():
			get_tree().reload_current_scene()
		return

	_elapsed += delta
	# Survival trickle: 10 points per second.
	# (THE HEIST: this line adds zero. int(0.016 * 10) rounds down to 0,
	# sixty times a second, forever. See ch07-2 for the fix — but run it
	# first and watch the score not tick. That's the lesson.)
	GameState.add_score(int(delta * SURVIVAL_POINTS_PER_SECOND))
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
