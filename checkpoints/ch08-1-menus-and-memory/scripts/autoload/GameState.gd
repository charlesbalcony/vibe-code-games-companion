extends Node
## Global game state: score for the current run and the persistent high
## score. The stage manager — sets come and go; staff remembers.

const SAVE_PATH := "user://highscore.save"

var score: int = 0
var high_score: int = 0


func _ready() -> void:
	_load_high_score()


func add_score(points: int) -> void:
	score += points
	if score > high_score:
		high_score = score
		# Save when the record breaks, not when the game quits —
		# quits are unreliable; triumphs are not.
		_save_high_score()


func reset_run() -> void:
	score = 0


func _load_high_score() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		return
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file:
		high_score = file.get_32()


func _save_high_score() -> void:
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_32(high_score)
