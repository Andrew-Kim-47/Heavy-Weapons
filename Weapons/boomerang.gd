extends Weapon


enum State {Throw, Return, Loose}
var state
var acceleration = 170

func _init():
	state = State.Throw
	cooldown_step_size = 0.4
	full_recharge_speed = 0.35
	recharge_speed = 0.35
	fire_delay = 0.07
	range = 900
	damage = 150
	max_damage = damage
	speed = 400

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	$AnimationPlayer.play("Spin")
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
	
	if travelled_distance > range:
		queue_free()
	
