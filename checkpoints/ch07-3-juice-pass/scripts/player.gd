extends Area2D
## The player: a rubber duck bobbing at the bottom of the pipe.
## Placeholder art on purpose — it gets a real sprite in chapter 12.

const SPEED := 420.0
const RADIUS := 26.0

var _half_width := RADIUS + 4.0
var _bob_time := 0.0


func _ready() -> void:
	var shape := CollisionShape2D.new()
	var circle := CircleShape2D.new()
	circle.radius = RADIUS * 0.8  # forgiving hitbox: players blame the game, not themselves
	shape.shape = circle
	add_child(shape)


func _process(delta: float) -> void:
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction == 0.0:
		# WASD fallback until we set up proper input actions (chapter 8).
		if Input.is_key_pressed(KEY_A):
			direction = -1.0
		elif Input.is_key_pressed(KEY_D):
			direction = 1.0
	position.x += direction * SPEED * delta

	var view_width := get_viewport_rect().size.x
	position.x = clampf(position.x, _half_width, view_width - _half_width)

	_bob_time += delta
	position.y = 880.0 + sin(_bob_time * 3.0) * 4.0
	queue_redraw()


func _draw() -> void:
	# Placeholder duck: yellow circle body, orange beak, judgmental eye.
	draw_circle(Vector2.ZERO, RADIUS, Color("f7d43c"))
	draw_circle(Vector2(-9, -20), RADIUS * 0.55, Color("f7d43c"))
	draw_rect(Rect2(-26, -26, 12, 8), Color("e88a2d"))
	draw_circle(Vector2(-10, -24), 3.0, Color("2b2b2b"))
