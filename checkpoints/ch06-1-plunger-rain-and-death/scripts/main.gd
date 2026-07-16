extends Node2D
## The game loop: spawn plungers, handle death, restart on any key.

const SPAWN_WAIT := 0.9

var game_over := false
var _restart_armed := false

@onready var spawn_timer: Timer = $SpawnTimer
@onready var game_over_label: Label = $HUD/GameOverLabel


func _ready() -> void:
	game_over_label.visible = false
	spawn_timer.wait_time = SPAWN_WAIT
	spawn_timer.timeout.connect(_spawn_faller)


func _process(_delta: float) -> void:
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


func _spawn_faller() -> void:
	if game_over:
		return
	var faller := Faller.new()
	faller.position = Vector2(randf_range(40.0, get_viewport_rect().size.x - 40.0), -60.0)
	faller.hit_player.connect(_on_faller_hit_player)
	add_child(faller)


func _on_faller_hit_player(_faller: Faller) -> void:
	game_over = true
	spawn_timer.stop()
	game_over_label.text = "CLOGGED!\n\npress any key to re-flush"
	game_over_label.visible = true
