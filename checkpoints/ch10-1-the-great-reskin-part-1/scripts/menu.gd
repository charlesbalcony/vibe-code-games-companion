extends Control
## The front door: title, best score, Play, Quit.


func _ready() -> void:
	$Center/BestLabel.text = "Best: %d" % GameState.high_score
	$Center/PlayButton.pressed.connect(_on_play)
	$Center/QuitButton.pressed.connect(_on_quit)
	$Center/PlayButton.grab_focus()


func _on_play() -> void:
	get_tree().change_scene_to_file("res://scenes/Main.tscn")


func _on_quit() -> void:
	get_tree().quit()
