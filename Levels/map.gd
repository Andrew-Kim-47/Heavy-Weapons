class_name Map extends Node2D

@onready var player = get_node("Player")
var enemies_killed = 0
var enemy_quota = 50
var cash = 0
var is_ending = false

var homing_target
var shortest_distance = 1280

var slow_time = false

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
		Singleton.current_level = name.split("_")[1]
		get_tree().change_scene_to_file("res://Levels/finish_screen.tscn")
		
	for enemy in get_tree().get_nodes_in_group("Enemy_target"):
		var distance = enemy.position.distance_to(get_viewport().get_mouse_position())
		if distance < shortest_distance:
			homing_target = enemy
			shortest_distance = distance
			
	
	if homing_target == null:
		shortest_distance = 1280

func _on_spawn_timer_timeout():
	spawn_enemy("res://Characters/enemy.tscn")
	
	
func spawn_enemy(enemy_type):
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
		var enemy = load(enemy_type).instantiate()
		enemy.position = new_pos
		add_child(enemy)
		await get_tree().create_timer(0.5).timeout
	portal.shrink()
	
func kill_enemy():
	enemies_killed += 1
	

