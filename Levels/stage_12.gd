extends Map

@onready var path = $Path2D/PathFollow2D
var random_progress

func _on_tank_spawn_timer_timeout():
	random_progress = randf()
	path.progress_ratio = random_progress
	var enemy_tank = load("res://Characters/enemy_tank.tscn").instantiate()
	enemy_tank.global_position = path.global_position
	if random_progress < 0.18:
		enemy_tank.rotation = PI / 4 * randi_range(-1, 1)
	elif random_progress < 0.5:
		enemy_tank.rotation = -PI / 2  + PI / 4 * randi_range(-1, 1)
	elif random_progress < 0.68:
		enemy_tank.rotation = -PI + PI / 4 * randi_range(-1, 1)
	else:
		enemy_tank.rotation = PI / 2 + PI / 4 * randi_range(-1, 1)
	add_child(enemy_tank)
