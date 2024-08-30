extends Enemy

var projectile_type = "res://Characters/enemy_shot.tscn"
var fire_delay = 2

func _init():
	max_health = 1000
	health = max_health

func _ready():
	$ShootTimer.start(fire_delay)
	
	
func _physics_process(delta):
	%Shadow.global_position = global_position + Vector2(0, 3)
	%Shadow.rotation = 0
	if get_parent().slow_time:
		$ShootTimer.wait_time = 5
	else:
		$ShootTimer.wait_time = 3


func _on_shoot_timer_timeout():
	$ShootTimer.start(fire_delay)
	var shot = load(projectile_type).instantiate()
	shot.direction = position.direction_to(player.position)
	shot.position = position
	get_parent().add_child(shot)
