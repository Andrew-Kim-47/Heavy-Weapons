extends Weapon

@onready var map = get_parent()

func _init():
	speed = 900
	cooldown_step_size = 0.2
	recharge_speed = 0.3
	full_recharge_speed = 0.4
	fire_delay = 0.1
	range = 1000
	damage = 100
	max_damage = damage

func _physics_process(delta):
	if map.homing_target != null:
		var target = map.homing_target.position - position 
		var ang = target.angle()
		var d = PI * 0.05
		ang = lerp_angle(rotation, ang, 1)
		ang = clamp(ang, rotation - d, rotation + d)
		direction = Vector2.from_angle(ang)
		position +=  direction * speed * delta
		rotation = ang
	else:
		position += direction * speed * delta
		
	travelled_distance += speed * delta
	if travelled_distance > range:
		queue_free()
