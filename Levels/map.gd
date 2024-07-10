extends Node2D

@onready var player = get_node("Player")
var enemies_killed = 0
var enemy_quota = 100
var cash = 0
var is_ending = false

func _process(delta):
	if enemies_killed >= enemy_quota and !is_ending:
		is_ending = true
		var end = load("res://Animations/end_level.tscn").instantiate()
		add_child(end)
		await get_tree().create_timer(5).timeout
		Singleton.collect(cash)
		Singleton.add_kills(enemies_killed)
		Singleton.level_kills = enemies_killed
		Singleton.level_cash = cash
		get_tree().change_scene_to_file("res://Levels/finish_screen.tscn")
		
		

func _on_spawn_timer_timeout():
	var player_position = player.position
	var portal = load("res://Animations/portal.tscn").instantiate()
	var randx = randf_range(-get_viewport_rect().size[0] / 2, get_viewport_rect().size[0] / 2)
	var randy = randf_range(-get_viewport_rect().size[1] / 2, get_viewport_rect().size[1] / 2)
	var new_x = clamp(player_position.x + randx, -750, 750)
	var new_y = clamp(player_position.y + randy, -500, 500)
	var new_pos = Vector2(new_x, new_y)
	portal.position = new_pos
	add_child(portal)
	await get_tree().create_timer(1).timeout
	for n in randi_range(4,6):
		var enemy = load("res://Characters/enemy.tscn").instantiate()
		enemy.position = new_pos
		enemy.speed = randi_range(80, 120)
		add_child(enemy)
		await get_tree().create_timer(0.5).timeout
	portal.shrink()
	
func kill_enemy():
	enemies_killed += 1
	

