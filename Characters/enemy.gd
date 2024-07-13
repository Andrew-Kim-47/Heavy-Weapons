class_name Enemy extends CharacterBody2D

@onready var player = get_parent().get_node("Player")
@onready var nav = $NavigationAgent2D as NavigationAgent2D
var drop = preload("res://Characters/small_drop.tscn").instantiate()
var explosion = preload("res://Animations/explosion.tscn").instantiate()
var health = 100
var speed = 100
var player_position
var damage = 15
signal health_changed

var time = 0
var radius
var rand_angle = randi_range(0,360)
var just_hit = false

func _ready():
	radius = position.distance_to(player.position) / 2

func _physics_process(delta):
	$Shadow.global_position = global_position + Vector2(0, 15)
	$Shadow.rotation = 0
	#velocity = (player.position - position).normalized() * speed
	#move_and_slide()
	#look_at(player.position)
	
	#var dir = to_local(nav.get_next_path_position()).normalized()
	#nav.set_velocity(dir * speed)
	#move_and_slide()
	#$Sprite2D.rotation = velocity.angle()
	if position.distance_to(player.position) < 5:
		just_hit = true
		$Timer.start()
		time = 0
	if !just_hit:
		var next_pos = bezier(time)
		look_at(next_pos)
		velocity = position.direction_to(next_pos) * speed
		time += delta * 0.3
		if time > 1:
			time = 1
	move_and_slide()
	
	
func bezier(t):
	var p1 = Vector2(position.x + radius * cos(deg_to_rad(rand_angle)) , position.y + radius * sin(deg_to_rad(rand_angle)))
	#var p1 = Vector2(125, 50)
	var q0 = position.lerp(p1, t)
	var q1 = p1.lerp(player.position, t)
	var r = q0.lerp(q1, t)
	return r
	

func take_damage(damage):
	
	health -= damage
	health_changed.emit()
	if health <= 0:
		drop.position = position
		explosion.position = position
		get_parent().add_child(drop)
		get_parent().add_child(explosion)
		get_parent().kill_enemy()
		queue_free()
	

func _on_area_2d_area_entered(area):
	if area.is_in_group("Weapon") and !area.used: #Check if is weapon and hasn't already hit something else
		area.used = true
		take_damage(area.damage)
		area.queue_free()


func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	velocity = safe_velocity
	move_and_slide()
	$Sprite2D.rotation = velocity.angle()
	


func _on_timer_timeout():
	nav.target_position = player.global_position
	just_hit = false
	radius = position.distance_to(player.position) / 2
	rand_angle = randi_range(0,360)
