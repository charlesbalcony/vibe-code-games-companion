class_name Faller
extends Area2D
## Anything that falls down the pipe. Two kinds:
## HAZARD (a plunger — touch it and the run ends)
## PICKUP (a soap bubble — touch it for points)

enum Kind { HAZARD, PICKUP }

signal hit_player(kind: Kind, faller: Faller)

var kind: Kind = Kind.HAZARD
var fall_speed := 260.0
var _spin := 0.0


func _init(faller_kind: Kind = Kind.HAZARD, speed: float = 260.0) -> void:
	kind = faller_kind
	fall_speed = speed


func _ready() -> void:
	var shape := CollisionShape2D.new()
	var circle := CircleShape2D.new()
	circle.radius = 20.0 if kind == Kind.HAZARD else 16.0
	shape.shape = circle
	add_child(shape)
	area_entered.connect(_on_area_entered)
	# Bubbles fall gently and don't tumble — friendly at a glance.
	if kind == Kind.HAZARD:
		_spin = randf_range(-2.0, 2.0)
	else:
		fall_speed *= 0.7


func _process(delta: float) -> void:
	position.y += fall_speed * delta
	rotation += _spin * delta
	if position.y > get_viewport_rect().size.y + 60.0:
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.name == "Player":
		hit_player.emit(kind, self)


func _draw() -> void:
	if kind == Kind.HAZARD:
		# Placeholder plunger: red cup, wooden handle.
		draw_rect(Rect2(-4, -34, 8, 30), Color("b08050"))
		draw_circle(Vector2(0, 8), 20.0, Color("c0392b"))
		draw_rect(Rect2(-20, -4, 40, 12), Color("c0392b"))
	else:
		# Placeholder soap bubble: translucent circle with a shine.
		draw_circle(Vector2.ZERO, 16.0, Color(0.6, 0.85, 1.0, 0.5))
		draw_arc(Vector2.ZERO, 16.0, 0.0, TAU, 24, Color(0.8, 0.95, 1.0), 2.0)
		draw_circle(Vector2(-5, -6), 3.5, Color(1, 1, 1, 0.9))
