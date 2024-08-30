extends Enemy

var changed_angle
var distance_per_jump = randi_range(200, 700)
var distance_travelled = 0
var direction_angle 
var acceleration = 1

func _ready():
	direction_angle = position.angle_to_point(player.position)
	changed_angle = direction_angle + randf_range(-PI / 8, PI / 8)
	speed = 500

func _physics_process(delta):
	if distance_travelled > distance_per_jump:
		print('y')
		distance_travelled = 0
		distance_per_jump = randi_range(200, 700)
		direction_angle = position.angle_to_point(player.position)
		changed_angle = direction_angle + randf_range(-PI / 8, PI / 8)
		print(changed_angle)
		speed = 400
		await get_tree().create_timer(1.5).timeout
	else:
		direction_angle = lerp_angle(direction_angle, changed_angle, 0.2)
		velocity = Vector2.from_angle(direction_angle) * speed
		#speed -= acceleration
		distance_travelled += delta * speed
		move_and_slide()
