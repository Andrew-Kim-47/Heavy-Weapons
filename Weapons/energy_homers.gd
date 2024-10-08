extends Weapon

func _init():
	
	cooldown_step_size = 0.2
	speed = 300
	recharge_speed = 0.3
	full_recharge_speed = 0.4
	fire_delay = 0.1
	range = 1000
	damage = 500
	max_damage = damage
	print(speed)


func _physics_process(delta):
	if map.homing_target != null:
		var target = map.homing_target.position - position 
		var ang = target.angle()
		var d = PI * 0.03
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
