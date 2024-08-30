extends Enemy

func _ready():
	look_at(player.position)

func _physics_process(delta):
	$Shadow.global_position = global_position + Vector2(0, 15)
	$Shadow.rotation = 0
	velocity = Vector2.from_angle(rotation) * speed
	move_and_slide()


func _on_adjust_direction_timer_timeout():
	if position.angle_to(player.position) < 0:
		rotation -= 0.1
	elif position.angle_to(player.position) > 0:
		rotation += 0.1
