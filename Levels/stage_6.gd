extends Map

var random_progress
@onready var path = $Path2D/PathFollow2D

func _on_worm_spawn_timer_timeout():
	random_progress = randf()
	path.progress_ratio = random_progress
	var enemy_worm = load("res://Characters/enemy_worm.tscn").instantiate()
	enemy_worm.global_position = path.global_position
	if random_progress < 0.18:
		enemy_worm.rotation = 90 + 45 * randi_range(-1, 1)
	elif random_progress < 0.5:
		enemy_worm.rotation = 45 * randi_range(-1, 1)
	elif random_progress < 0.68:
		enemy_worm.rotation = -90 + 45 * randi_range(-1, 1)
	else:
		enemy_worm.rotation = -90 + 45 * randi_range(-1, 1)
	add_child(enemy_worm)
