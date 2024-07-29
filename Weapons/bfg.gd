extends Weapon

func _init():
	speed = 200
	cooldown_step_size = 0.2
	recharge_speed = 0.3
	full_recharge_speed = 0.4
	fire_delay = 0.1
	range = 1000
	damage = 500
	max_damage = 10000

func _ready():
	direction = Vector2.RIGHT.rotated(rotation)
	$AnimationPlayer.play("Grow")
