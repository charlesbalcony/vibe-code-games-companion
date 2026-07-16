extends CanvasLayer
## The pause overlay. This layer keeps processing while the tree is
## paused (the process-mode trick) so Escape can resume.


func _ready() -> void:
	$Overlay.visible = false
	$Overlay/Center/ResumeButton.pressed.connect(_toggle)
	$Overlay/Center/MenuButton.pressed.connect(_on_menu)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		_toggle()


func _toggle() -> void:
	var paused := not get_tree().paused
	get_tree().paused = paused
	$Overlay.visible = paused


func _on_menu() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
