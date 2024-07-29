extends Weapon

var original_direction

func _init():
	cooldown_step_size = 0.2
	recharge_speed = 0.3
	full_recharge_speed = 0.4
	fire_delay = 0.1
	range = 1000
	damage = 500
	max_damage = damage

func _ready():
	direction = Vector2.RIGHT.rotated(rotation)
	original_direction = direction
func _physics_process(delta):
	position +=  direction * speed * delta
	rotation = direction.angle()


func _on_change_direction_timer_timeout():
	direction = original_direction.rotated(PI/2 * randi_range(-1, 1))
