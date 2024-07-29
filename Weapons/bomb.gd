extends Weapon

var target
var explode = false

func _init():
	speed = 600
	cooldown_step_size = 0.2
	recharge_speed = 0.3
	full_recharge_speed = 0.4
	fire_delay = 0.1
	range = 1000
	damage = 100
	max_damage = 100000
	
func _ready():
	$AnimationPlayer.play("Shrink")
	direction = Vector2.RIGHT.rotated(rotation)
	target = get_global_mouse_position()
	
func _physics_process(delta):
	position += direction * speed * delta
	if position.distance_to(target) < 15 and !explode:
		speed = 0
		explode = true
		$circle_1_1.visible = false
		$circle_1_2.visible = false
		$circle_2_1.visible = false
		$circle_2_2.visible = false
		$circle_2_3.visible = false
		$circle_3.visible = false
		$circle_4.visible = false
		$Sprite2D.visible = true
		$CollisionShape2D.disabled = false 
		$AnimationPlayer.play("Grow")
		await get_tree().create_timer(0.35).timeout
		queue_free()
		
