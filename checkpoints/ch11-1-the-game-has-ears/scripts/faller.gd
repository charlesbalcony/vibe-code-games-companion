class_name Faller
extends Area2D
## Anything that falls down the pipe. Two kinds:
## HAZARD (a plunger — touch it and the run ends)
## PICKUP (a soap bubble — touch it for points)
## Hazards also report near-misses, so the game can wink at recklessness.

enum Kind { HAZARD, PICKUP }

signal hit_player(kind: Kind, faller: Faller)
signal near_miss(faller: Faller)

const NEAR_MISS_DISTANCE := 60.0

var kind: Kind = Kind.HAZARD
var fall_speed := 260.0
var _spin := 0.0
var _player: Node2D
var _passed_player := false


func _init(faller_kind: Kind = Kind.HAZARD, speed: float = 260.0) -> void:
	kind = faller_kind
	fall_speed = speed


func _ready() -> void:
	var shape := CollisionShape2D.new()
	var circle := CircleShape2D.new()
	circle.radius = 20.0 if kind == Kind.HAZARD else 16.0
	shape.shape = circle
	add_child(shape)
	var sprite := Sprite2D.new()
	if kind == Kind.HAZARD:
		sprite.texture = load("res://assets/sprites/plunger.png")
		sprite.scale = Vector2.ONE * (48.0 / float(sprite.texture.get_width()))
	else:
		sprite.texture = load("res://assets/sprites/bubble.png")
		sprite.scale = Vector2.ONE * (36.0 / float(sprite.texture.get_width()))
	add_child(sprite)
	area_entered.connect(_on_area_entered)
	_player = get_parent().get_node_or_null("Player")
	# Bubbles fall gently and don't tumble — friendly at a glance.
	if kind == Kind.HAZARD:
		_spin = randf_range(-2.0, 2.0)
	else:
		fall_speed *= 0.7


func _process(delta: float) -> void:
	position.y += fall_speed * delta
	rotation += _spin * delta

	# A hazard sliding past the duck's height without a hit is a near-miss.
	if kind == Kind.HAZARD and not _passed_player and _player and position.y > _player.position.y:
		_passed_player = true
		if absf(position.x - _player.position.x) < NEAR_MISS_DISTANCE:
			near_miss.emit(self)

	if position.y > get_viewport_rect().size.y + 60.0:
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.name == "Player":
		hit_player.emit(kind, self)

