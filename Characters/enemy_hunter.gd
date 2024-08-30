extends Enemy

var rotation_complete
var distance_per_jump = 200
var distance_travelled = 0
var target_point

func _ready():
	speed = 200
	rotation = position.angle_to_point(player.position)
	rotation_complete = true
	original_speed = speed
	if map.slow_time:
		slow_time()
		
func _physics_process(delta):
	if rotation_complete:
		velocity = Vector2.from_angle(rotation) * speed
		move_and_slide()
		distance_travelled += speed * delta
		#if distance_travelled < distance_per_jump / 2:
			#speed = min(speed + acceleration, max_speed)
		#else:
			#speed = max(speed - acceleration, 0)
		if distance_travelled > distance_per_jump:
			#angle = lerp_angle(rotation, angle, 1)
			#angle = clamp(angle, rotation - max_turn_angle, rotation + max_turn_angle)
			target_point = player.position
			rotation_complete = false
	else:
		distance_travelled = 0
		rotation = lerp_angle(rotation, position.angle_to_point(target_point), 0.2)
		print(position.direction_to(target_point))
		print(Vector2.from_angle(rotation))
		print(Vector2.from_angle(rotation).angle_to(position.direction_to(target_point)))
			
		
		if abs(Vector2.from_angle(rotation).angle_to(position.direction_to(target_point))) < PI / 10:
			rotation_complete = true
