extends Node
## Global game state: the score for the current run.
## Lives in an autoload so it survives the scene reload on restart.
## (High score persistence arrives in chapter 8.)

var score: int = 0


func add_score(points: int) -> void:
	score += points


func reset_run() -> void:
	score = 0
