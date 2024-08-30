extends Enemy

var moving = true
var distance_per_jump = 100
var distance_travelled = 0
var max_speed = 400
var direction
var acceleration = 30

func _ready():
	direction = position.direction_to(player.position)
	speed = 0

func _physics_process(delta):
	if moving:
		velocity = direction * speed
		move_and_slide()
		distance_travelled += speed * delta
		if distance_travelled < distance_per_jump / 2:
			speed = min(speed + acceleration, max_speed)
		else:
			speed = max(speed - acceleration, 0)
		if distance_travelled > distance_per_jump:
			moving = false


func _on_jump_timer_timeout():
	moving = true
	var angle = position.angle_to_point(player.position) + randf_range(-PI / 4, PI / 4)
	rotation = angle
	direction = Vector2.from_angle(angle)
	speed = 0
	distance_travelled = 0
	
