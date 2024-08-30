class_name Enemy extends CharacterBody2D

@onready var player = get_parent().get_node("Player")
@onready var map = get_parent()
@onready var nav = $NavigationAgent2D as NavigationAgent2D
var drop = preload("res://Characters/small_drop.tscn").instantiate()
var explosion = preload("res://Animations/explosion.tscn").instantiate()
var max_health = 100
var health = max_health
var original_speed
var speed = randi_range(80, 120)
var player_position
var damage = 15
signal health_changed

var radius
var rand_angle = randi_range(0,360)
var just_hit = false

var max_turn_angle = PI * 0.01

func _ready():
	radius = position.distance_to(player.position) / 2
	original_speed = speed
	if map.slow_time:
		slow_time()

func _physics_process(delta):
	$Shadow.global_position = global_position + Vector2(0, 15)
	$Shadow.rotation = 0
	
	#if position.distance_to(player.position) < 5:
		#just_hit = true
		#$HitResetTimer.start()
	if !just_hit:
		var target_direction = player.position - position 
		var angle = target_direction.angle()
		angle = lerp_angle(rotation, angle, 1)
		angle = clamp(angle, rotation - max_turn_angle, rotation + max_turn_angle)
		velocity = Vector2.from_angle(angle) * speed
		rotation = angle
		
	move_and_slide()
	
	

func take_damage(damage):
	
	health -= damage
	health_changed.emit()
	if health <= 0:
		if map.is_ending:
			drop.worth *= 2
		drop.global_position = $Sprite2D.global_position
		explosion.global_position = $Sprite2D.global_position
		get_parent().add_child(drop)
		get_parent().add_child(explosion)
		get_parent().kill_enemy()
		queue_free()
	
func slow_time():
	speed = speed * 0.2
	
func reset_time():
	speed = original_speed
	

func _on_area_2d_area_entered(area):
	if area.is_in_group("Weapon") and !area.used: #Check if is weapon and hasn't already hit something else
		area.used = true
		take_damage(area.damage)
		area.hit(max_health)


func _on_hit_reset_timer_timeout():
	just_hit = false
