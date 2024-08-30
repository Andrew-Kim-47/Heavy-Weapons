extends Projectile

@onready var path = $Path2D/PathFollow2D

func _init():
	speed = 300

func _physics_process(delta):
	$Sprite2D.global_position = path.global_position
	path.progress += delta * speed
	if path.progress_ratio > 0.98:
		queue_free()
