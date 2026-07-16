extends Node2D
## The game loop: spawn fallers, ramp difficulty, score, game over —
## now with juice. Death is an EVENT, not an email.

const PICKUP_CHANCE := 0.35
const SURVIVAL_POINTS_PER_SECOND := 10.0
const BUBBLE_POINTS := 25
const NEAR_MISS_POINTS := 5
const START_FALL_SPEED := 240.0
const START_SPAWN_WAIT := 0.9
const MIN_SPAWN_WAIT := 0.35
const RAMP_PER_SECOND := 4.0
const HIT_STOP_SECONDS := 0.1
const SHAKE_SECONDS := 0.5
const SHAKE_STRENGTH := 12.0

var game_over := false
var _restart_armed := false
var _elapsed := 0.0
var _score_accum := 0.0
var _shake_time := 0.0

@onready var spawn_timer: Timer = $SpawnTimer
@onready var camera: Camera2D = $Camera2D
@onready var score_label: Label = $HUD/ScoreLabel
@onready var game_over_label: Label = $HUD/GameOverLabel


func _ready() -> void:
	Engine.time_scale = 1.0  # heal any leak from a mid-effect scene change
	GameState.reset_run()
	game_over_label.visible = false
	camera.make_current()
	spawn_timer.wait_time = START_SPAWN_WAIT
	spawn_timer.timeout.connect(_spawn_faller)


func _process(delta: float) -> void:
	if _shake_time > 0.0:
		_shake_time -= delta
		var falloff := _shake_time / SHAKE_SECONDS
		camera.offset = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)) * SHAKE_STRENGTH * falloff
		if _shake_time <= 0.0:
			camera.offset = Vector2.ZERO

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
	faller.near_miss.connect(_on_near_miss)
	add_child(faller)


func _on_faller_hit_player(kind: Faller.Kind, faller: Faller) -> void:
	if kind == Faller.Kind.PICKUP:
		GameState.add_score(BUBBLE_POINTS)
		_burst(faller.position, Color(0.7, 0.9, 1.0), 14)
		_punch_score()
		faller.queue_free()
	else:
		_end_run()


func _on_near_miss(faller: Faller) -> void:
	if game_over:
		return
	GameState.add_score(NEAR_MISS_POINTS)
	_burst(faller.position, Color(1.0, 0.75, 0.3), 8)
	_float_text("CLOSE! +%d" % NEAR_MISS_POINTS, faller.position)


func _end_run() -> void:
	if game_over:
		return  # the funeral is idempotent: posthumous plungers change nothing
	game_over = true
	spawn_timer.stop()
	# Hit-stop: freeze the world for a beat (the timer ignores time scale),
	# then the shake hits. Silence, THEN drama.
	Engine.time_scale = 0.05
	await get_tree().create_timer(HIT_STOP_SECONDS, true, false, true).timeout
	Engine.time_scale = 1.0
	_shake_time = SHAKE_SECONDS
	game_over_label.text = "CLOGGED!\nScore: %d\n\npress any key to re-flush" % GameState.score
	game_over_label.visible = true


func _punch_score() -> void:
	score_label.pivot_offset = score_label.size / 2.0
	var tween := create_tween()
	tween.tween_property(score_label, "scale", Vector2(1.3, 1.3), 0.06)
	tween.tween_property(score_label, "scale", Vector2.ONE, 0.12)


func _burst(pos: Vector2, color: Color, amount: int) -> void:
	var particles := CPUParticles2D.new()
	particles.position = pos
	particles.one_shot = true
	particles.emitting = true
	particles.amount = amount
	particles.lifetime = 0.4
	particles.explosiveness = 1.0
	particles.spread = 180.0
	particles.initial_velocity_min = 60.0
	particles.initial_velocity_max = 140.0
	particles.gravity = Vector2(0, 220)
	particles.color = color
	particles.scale_amount_min = 3.0
	particles.scale_amount_max = 6.0
	add_child(particles)
	get_tree().create_timer(1.0).timeout.connect(particles.queue_free)


func _float_text(text: String, pos: Vector2) -> void:
	var label := Label.new()
	label.text = text
	label.add_theme_font_size_override("font_size", 30)
	label.position = pos - Vector2(40, 44)
	add_child(label)
	var tween := create_tween()
	tween.tween_property(label, "position:y", label.position.y - 40.0, 0.6)
	tween.parallel().tween_property(label, "modulate:a", 0.0, 0.6)
	tween.tween_callback(label.queue_free)
