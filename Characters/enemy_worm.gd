extends Enemy



func _ready():
	speed = 50
	health = 300
	$HealthBar.max_value = 200

func _physics_process(delta):
	$Shadow.global_position = global_position + Vector2(0, 1)
	$Shadow.rotation = 0
	$AnimatedSprite2D.play("Move")
	$Shadow.play("Move")
	var direction = Vector2.UP.rotated(rotation)
	position += direction * speed * delta




