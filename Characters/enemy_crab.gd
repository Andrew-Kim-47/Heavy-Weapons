extends Enemy


enum State {Rushing, Hovering, Moving}
var state
var target_spot
var hover_distance
var only_hover = true
var angle = 0
var direction
var acceleration = 5

func _ready():
	speed = 150
	original_speed = 150
	rand_angle = player.position.angle_to_point(position) + deg_to_rad(randi_range(-30, 30))
	hover_distance = randi_range(100, 300)
	target_spot = Vector2(player.position.x + hover_distance * cos(rand_angle) , player.position.y + hover_distance * sin(rand_angle))
	position = player.position + Vector2.RIGHT.rotated(angle) * hover_distance
	direction = Vector2.RIGHT
func _physics_process(delta):
	if state != State.Moving and player.velocity != Vector2.ZERO:
		state = State.Moving
		#speed = 0
	if player.velocity == Vector2.ZERO:
		state = State.Hovering
	look_at(player.position)
	$Shadow.global_position = global_position + Vector2(0, 15)
	$Shadow.rotation = 0
	direction = -Vector2.RIGHT.rotated(angle).orthogonal()
	velocity = direction * speed
	if state == State.Moving:
		direction += position.direction_to(player.position)
		#speed = min(original_speed, speed + acceleration)
		velocity += direction * speed
	
	move_and_slide()
	#position = player.position + Vector2.RIGHT.rotated(angle) * hover_distance
	angle += delta
	#hover_distance += randf_range(-1, 1)
	
	
	#if only_hover:
		#position = target_spot
	#elif position.distance_to(player.position) < 0:
		#$GetNextSpotTimer.set_paused(true)
		#velocity = (position - player.position).normalized().rotated(PI/2 + deg_to_rad(randi_range(-5,5))) * speed
	#else:
		#velocity = position.direction_to(target_spot) * speed
		#$GetNextSpotTimer.set_paused(false)
	#move_and_slide()
	
func find_target_spot():
	rand_angle = player.position.angle_to_point(position) + deg_to_rad(randi_range(-45, 45))
	target_spot = Vector2(player.position.x + 100 * cos(rand_angle) , player.position.y + 100 * sin(rand_angle))


func _on_get_next_spot_timer_timeout():
	pass
	#rand_angle = player.position.angle_to_point(position) + deg_to_rad(randi_range(-45, 45))
	#target_spot = Vector2(player.position.x + 100 * cos(rand_angle) , player.position.y + 100 * sin(rand_angle))
