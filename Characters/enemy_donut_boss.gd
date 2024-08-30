extends Enemy

var state = "Firing"
var state_repetitions = 0

var distance_travelled = 0
var distance_per_chase = 500

signal done_moving
var moving = false

func _ready():
	next_phase()

func _physics_process(delta):
	look_at(player.position)
	if moving:
		velocity = Vector2.from_angle(rotation) * speed
		move_and_slide()
		distance_travelled += delta * speed
		if distance_travelled > distance_per_chase:
			moving = false
			done_moving.emit()
	
			
func next_phase():
	$AnimationPlayer.play("Flicker In")
	await get_tree().create_timer(2).timeout
	if state == "Firing":
		state_repetitions += 1
		await fire_projectiles()
		if state_repetitions == 4:
			state = "Chasing"
			state_repetitions = 0
	else:
		moving = true
		fire_random()
		await done_moving
		distance_travelled = 0
		await fire_donuts()
		state = "Firing"
		
	$AnimationPlayer.play("Flicker Out")
	await get_tree().create_timer(2).timeout
	next_phase()
	
func fire_projectiles():
	print(state_repetitions)
	var projectile1
	var projectile2
	var projectile3
	for i in range(20):
		projectile1 = load("res://Characters/enemy_square_projectile.tscn").instantiate()
		projectile2 = load("res://Characters/enemy_square_projectile.tscn").instantiate()
		projectile3 = load("res://Characters/enemy_square_projectile.tscn").instantiate()
		projectile1.rotation = rotation + PI / 12
		projectile2.rotation = rotation 
		projectile3.rotation = rotation - PI / 12
		projectile1.position = position
		projectile2.position = position
		projectile3.position = position
		get_parent().add_child(projectile1)
		get_parent().add_child(projectile2)
		get_parent().add_child(projectile3)
		await get_tree().create_timer(0.1).timeout

func fire_random():
	var shot1
	var shot2
	var shot3
	var direction_angle
	for i in range(10):
		shot1 = load("res://Characters/enemy_shot.tscn").instantiate()
		shot2 = load("res://Characters/enemy_shot.tscn").instantiate()
		shot3 = load("res://Characters/enemy_shot.tscn").instantiate()
		shot1.position = position
		shot2.position = position
		shot3.position = position
		shot1.original_speed = 300
		shot2.original_speed = 300
		shot3.original_speed = 300
		direction_angle = randf_range(0, TAU)
		shot1.direction = Vector2.from_angle(direction_angle)
		shot2.direction = Vector2.from_angle(direction_angle + TAU / 3)
		shot3.direction = Vector2.from_angle(direction_angle - TAU / 3)
		get_parent().add_child(shot1)
		get_parent().add_child(shot2)
		get_parent().add_child(shot3)
		await get_tree().create_timer(0.7).timeout
		
func fire_donuts():
	for i in range(10):
		var donut = load("res://Characters/enemy_donut_shield.tscn").instantiate()
		donut.position = position - Vector2(175, 0)
		get_parent().add_child(donut)
		await get_tree().create_timer(0.5).timeout
		
	
