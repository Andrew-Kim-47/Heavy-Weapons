extends Enemy

var randx_value = randf_range(-1 , 1)
var randy_value = randf_range(-1 , 1)
var direction = Vector2(randx_value, randy_value).normalized()

var new_angle = direction.angle()
var direction_change_max = deg_to_rad(60)

func _ready():
	speed = 50
	rotation = direction.angle()
	velocity = direction * speed

func _physics_process(delta):
	$Shadow.global_position = global_position + Vector2(0, 15)
	$Shadow.rotation = 0
	if speed < 100:
		speed += 1
	rotation = lerp_angle(rotation, new_angle, 0.05)
	velocity = Vector2(speed, 0).rotated(rotation)
	move_and_slide()


func _on_change_direction_timer_timeout():
	#print(rotation)
	var weight = randi_range(1,10)
	if weight < 7:
		var modded_rotation = fmod(rotation, 2 * PI)
		var angle_diff = fmod((player.position - position).angle(), 2 * PI)
		if abs(angle_diff - (modded_rotation - direction_change_max)) < abs(angle_diff - (modded_rotation + direction_change_max)):
			new_angle = rotation - min(abs(angle_diff - modded_rotation), direction_change_max)
		else:
			new_angle = rotation + min(abs(angle_diff - modded_rotation), direction_change_max)
	else:
		new_angle = rotation + randf_range(-direction_change_max, direction_change_max)
	
