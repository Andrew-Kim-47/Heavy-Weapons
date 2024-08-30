extends Enemy

var direction = Vector2.LEFT
var angle = deg_to_rad(20)
var acceleration = 5
@onready var path = $Path2D/PathFollow2D

func _init():
	speed = 50

func _physics_process(delta):
	#velocity = direction * speed
	#move_and_slide()
	path.progress += delta * speed
	speed += acceleration
	acceleration += 0.1
	$Sprite2D.global_position = path.global_position
	$Area2D.global_position = path.global_position
	if path.progress_ratio > 0.98:
		queue_free()

func _on_timer_timeout():
	$Timer.wait_time *= 1.05
	direction = direction.rotated(angle)
	speed += acceleration
