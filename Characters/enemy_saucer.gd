extends Enemy

var target_direction
var time = 0
var freq = 2
var amp = 150

func _init():
	speed = randi_range(180, 220)

#func _ready():
	#target_direction = player.position - position
	#original_speed = speed

func _physics_process(delta):
	$Shadow.global_position = global_position + Vector2(0, 15)
	$Shadow.rotation = 0
	
	if position.distance_to(player.position) < 5:
		just_hit = true
		$HitResetTimer.start()
	if !just_hit:
		target_direction = player.position - position
		var angle = target_direction.angle()
		angle = lerp_angle(rotation, angle, 1)
		angle = clamp(angle, rotation - max_turn_angle, rotation + max_turn_angle)
		
		if abs(target_direction.angle() - angle) > PI:
			speed = max(120, speed - 0.3)
		else:
			speed = min(original_speed, speed + 0.3)
		#velocity = Vector2.from_angle(angle) * speed
		print(speed)
		rotation = angle
		var v = Vector2.RIGHT * speed
		v.y += cos(time * freq) * amp
		time += delta
		velocity = v.rotated(angle)
		
		
	move_and_slide()
	


func _on_timer_timeout():
	target_direction = player.position - position
