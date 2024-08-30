extends Enemy

var prev_rotation
var weight = 0.9

func _physics_process(delta):
	$EnemyTankCannon.look_at(player.position)
	prev_rotation = $EnemyTankCannon.rotation
	
	if player.velocity != Vector2.ZERO:
		weight = 0.2
	else:
		weight = 0.2
	prev_rotation = $EnemyTankCannon.rotation
	
	var angle_change = (position.angle_to_point(player.position) - rotation)  * weight
	#rotation = lerp_angle(rotation, rotation + angle_change, 0.5)
	rotation = rotation + angle_change
	#look_at(player.position)
	
	velocity = Vector2.from_angle(rotation) * 50
	move_and_slide()
	


func _on_shoot_timer_timeout():
	var shot = load("res://Characters/enemy_star.tscn").instantiate()
	shot.direction = position.direction_to(player.position)
	shot.global_position = $EnemyTankCannon/Marker2D.global_position
	get_parent().add_child(shot)
