extends Weapon

@onready var player = get_parent().get_node("Player")
var blinks = 0
var rand_rotation

func _init():
	cooldown_step_size = 0.2
	recharge_speed = 0.3
	full_recharge_speed = 0.4
	fire_delay = 0.1
	range = 1000
	damage = 500
	max_damage = 10000

func _ready():
	rand_rotation = randf_range(0, 2*PI)
	rotation = rand_rotation
	$AnimatedSprite2D.play("Firing")

func _physics_process(delta):
	position = player.position


func _on_change_rotation_timer_timeout():
	blinks += 1
	if blinks == 6:
		queue_free()
	rand_rotation = randf_range(0, 2*PI)
	rotation = rand_rotation
	
	
