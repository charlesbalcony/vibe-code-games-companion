extends Area2D
## The player: a rubber duck bobbing at the bottom of the pipe.
## Chapter 10: the placeholder _draw() art retired with honor.

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
	# The chapter 10 costume change: same actor, new face. Hitbox untouched.
	var sprite := Sprite2D.new()
	sprite.texture = load("res://assets/sprites/duck.png")
	sprite.scale = Vector2.ONE * (RADIUS * 2.3 / float(sprite.texture.get_width()))
	add_child(sprite)


func _process(delta: float) -> void:
	# Proper input actions: code asks for intentions, the input map
	# speaks hardware (arrows AND A/D — see project settings).
	var direction := Input.get_axis("move_left", "move_right")
	position.x += direction * SPEED * delta

	var view_width := get_viewport_rect().size.x
	position.x = clampf(position.x, _half_width, view_width - _half_width)

	_bob_time += delta
	position.y = 880.0 + sin(_bob_time * 3.0) * 4.0

