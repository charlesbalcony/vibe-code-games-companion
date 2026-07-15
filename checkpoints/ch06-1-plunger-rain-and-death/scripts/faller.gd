class_name Faller
extends Area2D
## A falling plunger. Touch it and the run ends.
## Placeholder art drawn in code, like everything else so far.

signal hit_player(faller: Faller)

const FALL_SPEED := 260.0


func _ready() -> void:
	var shape := CollisionShape2D.new()
	var circle := CircleShape2D.new()
	circle.radius = 20.0
	shape.shape = circle
	add_child(shape)
	area_entered.connect(_on_area_entered)


func _process(delta: float) -> void:
	position.y += FALL_SPEED * delta
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
