extends Enemy

var acceleration = 5
var direction_angle
var angle
var reversing

func _ready():
	speed = 400
	original_speed = 400
	look_at(player.position)
	velocity = Vector2.from_angle(rotation) * speed

func _physics_process(delta):
	#$Shadow.global_position = global_position + Vector2(0, 15)
	#$Shadow.rotation = 0
	var target_direction = player.position - position 
	angle = target_direction.angle()
	angle = lerp_angle(rotation, angle, 1)
	if !reversing:
		speed = min(speed + acceleration, original_speed)
		max_turn_angle =  PI * 0.01
		if abs(angle - rotation) > PI / 4:
			reversing = true
	else:
		speed -= acceleration
		#max_turn_angle =  PI * 0.005
		if speed < 150:
			#direction_angle = angle
			reversing = false
	direction_angle = clamp(angle, rotation - max_turn_angle, rotation + max_turn_angle)
	rotation = direction_angle
	velocity = Vector2.from_angle(direction_angle) * speed
	
	move_and_slide()
