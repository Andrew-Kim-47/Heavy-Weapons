extends Area2D


@export var speed = 400
@export var damage = 75
var travelled_distance = 0
const RANGE = 900
var direction
var cooldown_ = 3
var recharge_speed
var full_recharge_speed
var fire_delay = 0.07
var used = false #Boolean to make sure only one enemy gets hit

enum State {Throw, Return, Loose}
var state
var acceleration = 170

func _ready():
	direction = Vector2.RIGHT.rotated(rotation)
	state = State.Throw

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if state == State.Throw:
		speed -= acceleration * delta
		position += direction * speed * delta
		if speed <= 0:
			state = State.Return
	elif state == State.Return:
		direction = global_position.direction_to(get_parent().get_node("Player").global_position)
		position += direction * speed * delta
		state = State.Loose
	elif state == State.Loose:
		speed += acceleration * delta * 2
		position += direction * speed * delta
		travelled_distance += speed * delta
	
	if travelled_distance > RANGE:
		queue_free()
	
