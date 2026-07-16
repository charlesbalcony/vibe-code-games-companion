extends Control
## The front door: title, best score, Play, Quit.


var _music := AudioStreamPlayer.new()
var _click := AudioStreamPlayer.new()


func _ready() -> void:
	var tune: AudioStream = load("res://assets/music/menu.ogg")
	tune.loop = true
	_music.stream = tune
	_music.volume_db = -12.0
	add_child(_music)
	_music.play()
	_click.stream = load("res://assets/sfx/click.wav")
	add_child(_click)
	$Center/BestLabel.text = "Best: %d" % GameState.high_score
	$Center/PlayButton.pressed.connect(_on_play)
	$Center/QuitButton.pressed.connect(_on_quit)
	$Center/PlayButton.grab_focus()


func _on_play() -> void:
	_click.play()
	get_tree().change_scene_to_file("res://scenes/Main.tscn")


func _on_quit() -> void:
	get_tree().quit()
