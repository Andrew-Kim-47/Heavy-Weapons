extends Enemy

func _physics_process(delta):
	$Shadow.global_position = global_position + Vector2(0, 15)
	$Shadow.rotation = 0
	
	
	var target_direction = player.position - position 
	var angle = target_direction.angle()
	if abs(angle - rotation) < PI / 4:
		max_turn_angle =  PI * 0.01
	else:
		max_turn_angle = PI * 0.005
	angle = lerp_angle(rotation, angle, 1)
	angle = clamp(angle, rotation - max_turn_angle, rotation + max_turn_angle)
	velocity = Vector2.from_angle(angle) * speed
	rotation = angle
		
	move_and_slide()
