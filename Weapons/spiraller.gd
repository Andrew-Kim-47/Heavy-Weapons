extends Weapon

var angle = deg_to_rad(25)

var time = 0

func _init():
	speed = 900
	cooldown_step_size = 0.2
	recharge_speed = 0.3
	full_recharge_speed = 0.4
	fire_delay = 0.05
	range = 10000
	
func _ready():
	direction = Vector2.from_angle(rotation).normalized()

func _physics_process(delta):
	position += direction * speed * delta


func _on_timer_timeout():
	$Timer.wait_time *= 1.15
	direction = direction.rotated(angle)

