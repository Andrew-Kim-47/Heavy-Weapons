extends Enemy

var avoiding = false

func _physics_process(delta):
	if !avoiding:
		var target_direction = player.position - position 
		var angle = target_direction.angle()
		angle = lerp_angle(rotation, angle, 1)
		angle = clamp(angle, rotation - max_turn_angle, rotation + max_turn_angle)
		velocity = Vector2.from_angle(angle) * speed
		rotation = angle
	move_and_slide()

func _on_avoidance_circle_area_entered(area):
	avoiding = true
	if area.is_in_group("Weapon"):
		print('y')
		velocity = area.position.direction_to(position) * speed * 3
		move_and_slide()
	await get_tree().create_timer(0.3).timeout
	avoiding = false
