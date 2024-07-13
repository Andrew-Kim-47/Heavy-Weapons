extends Enemy


enum State {Rushing, Hovering}
var state
var target_spot
var hover_distance
var only_hover = true
func _ready():
	speed = 200
	rand_angle = player.position.angle_to_point(position) + deg_to_rad(randi_range(-30, 30))
	hover_distance = randi_range(200, 300)
	target_spot = Vector2(player.position.x + hover_distance * cos(rand_angle) , player.position.y + hover_distance * sin(rand_angle))
	
func _physics_process(delta):
	look_at(player.position)
	$Shadow.global_position = global_position + Vector2(0, 15)
	$Shadow.rotation = 0
	
	
	if only_hover:
		position = target_spot
	elif position.distance_to(player.position) < 0:
		$GetNextSpotTimer.set_paused(true)
		velocity = (position - player.position).normalized().rotated(PI/2 + deg_to_rad(randi_range(-5,5))) * speed
	else:
		velocity = position.direction_to(target_spot) * speed
		$GetNextSpotTimer.set_paused(false)
	move_and_slide()
	
func find_target_spot():
	rand_angle = player.position.angle_to_point(position) + deg_to_rad(randi_range(-45, 45))
	target_spot = Vector2(player.position.x + 100 * cos(rand_angle) , player.position.y + 100 * sin(rand_angle))


func _on_get_next_spot_timer_timeout():
	pass
	#rand_angle = player.position.angle_to_point(position) + deg_to_rad(randi_range(-45, 45))
	#target_spot = Vector2(player.position.x + 100 * cos(rand_angle) , player.position.y + 100 * sin(rand_angle))
