extends Control
## The front door: title, best score, Play, Quit.


var _music := AudioStreamPlayer.new()
var _click := AudioStreamPlayer.new()


func _ready() -> void:
	var bg := TextureRect.new()
	bg.texture = load("res://assets/sprites/background-pipe.png")
	bg.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	bg.set_anchors_preset(Control.PRESET_FULL_RECT)
	bg.modulate = Color(0.55, 0.55, 0.6)
	bg.show_behind_parent = true
	add_child(bg)
	move_child(bg, 0)
	var title := $Center/TitleLabel
	title.visible = false
	var logo := TextureRect.new()
	logo.texture = load("res://assets/sprites/logo-flush-rush.png")
	logo.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	logo.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	logo.custom_minimum_size = Vector2(330, 330)
	$Center.add_child(logo)
	$Center.move_child(logo, 0)
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
