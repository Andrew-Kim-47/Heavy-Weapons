extends Weapon

var target

func _init():
	speed = 600
	cooldown_step_size = 0.2
	recharge_speed = 0.3
	full_recharge_speed = 0.4
	fire_delay = 0.1
	range = 1000
	damage = 100
	max_damage = damage

func _ready():
	direction = position.direction_to(target)

func _physics_process(delta):
	position += direction * speed * delta
	if position.distance_to(target) < 20:
		queue_free()
