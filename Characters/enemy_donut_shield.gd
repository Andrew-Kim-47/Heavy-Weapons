extends Enemy

var direction = Vector2.LEFT
var angle = deg_to_rad(20)
var acceleration = 0.01
var cycles = 0
var first_circle = true
@onready var path = $Circle1/Circle1Follow

func _init():
	speed = 750

func _physics_process(delta):
	path.progress += delta * speed
	acceleration += 0.1
	$Sprite2D.global_position = path.global_position
	$Area2D.global_position = path.global_position
	if first_circle:
		if path.progress_ratio > 0.98:
			cycles += 1
			path.progress = 0
		if cycles == 3:
			path = $Circle2/Circle2Follow
			cycles = 0
			first_circle = false
	else:
		speed += acceleration
		if path.progress_ratio > 0.98:
			queue_free()
		

