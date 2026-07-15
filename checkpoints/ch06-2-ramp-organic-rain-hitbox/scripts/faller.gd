class_name Faller
extends Area2D
## A falling plunger. Touch it and the run ends.
## Falls with per-plunger speed variation and a lazy tumble —
## "more Nintendo, less spreadsheet."

signal hit_player(faller: Faller)

var fall_speed := 260.0
var _spin := 0.0


func _init(speed: float = 260.0) -> void:
	fall_speed = speed


func _ready() -> void:
	var shape := CollisionShape2D.new()
	var circle := CircleShape2D.new()
	circle.radius = 20.0
	shape.shape = circle
	add_child(shape)
	area_entered.connect(_on_area_entered)
	_spin = randf_range(-2.0, 2.0)


func _process(delta: float) -> void:
	position.y += fall_speed * delta
	rotation += _spin * delta
	if position.y > get_viewport_rect().size.y + 60.0:
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.name == "Player":
		hit_player.emit(self)


func _draw() -> void:
	# Placeholder plunger: red cup, wooden handle.
	draw_rect(Rect2(-4, -34, 8, 30), Color("b08050"))
	draw_circle(Vector2(0, 8), 20.0, Color("c0392b"))
	draw_rect(Rect2(-20, -4, 40, 12), Color("c0392b"))
