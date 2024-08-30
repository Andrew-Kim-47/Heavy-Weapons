extends Enemy


func _ready():
	speed = 50
	health = 300

func _physics_process(delta):
	$Shadow.global_position = global_position + Vector2(0, 3)
	$Shadow.rotation = 0
	$AnimatedSprite2D.play("Walk")
	$Shadow.play("Walk")
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta





