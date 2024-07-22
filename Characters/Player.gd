extends CharacterBody2D

@export var move_speed : float = 300
@export var fire_delay : float = 0.1
@export var health = 100

var weapon1_path = "res://Weapons/" + Singleton.weapon1 + ".tscn"
var weapon2_path = "res://Weapons/" + Singleton.weapon2 + ".tscn"
var weapon3_path = "res://Weapons/" + Singleton.weapon3 + ".tscn"
var cur_weapon_path = weapon1_path
var weapon1 = load(weapon1_path).instantiate()
var weapon2 = load(weapon2_path).instantiate()
var weapon3 = load(weapon3_path).instantiate()
var cur_weapon = weapon1
var on_cooldown = false
var hurt = false
var dead = false

signal health_changed
@onready var weapon1_stamina = get_parent().get_node("CanvasLayer/HUD").get_node("%Weapon1Stamina")
@onready var weapon2_stamina = get_parent().get_node("CanvasLayer/HUD").get_node("%Weapon2Stamina")
@onready var weapon3_stamina = get_parent().get_node("CanvasLayer/HUD").get_node("%Weapon3Stamina")
@onready var cur_weapon_stamina = weapon1_stamina

var spiraller_reverse = true #boolean to choose direction of spiraller

func _ready():
	pass

func _physics_process(_delta):
	if dead:
		return
	%Shadow.global_position = global_position + Vector2(0, 15)
	%Shadow.rotation = 0
	look_at(get_global_mouse_position())
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	velocity = input_direction * move_speed
	move_and_slide()
	
	if Input.is_action_pressed("left_click") and %FireDelayTimer.is_stopped() and !cur_weapon_stamina.weapon_on_cooldown:
		%FireDelayTimer.start(cur_weapon.fire_delay)
		if cur_weapon.is_in_group("Straight"):
			shoot()
		elif cur_weapon.is_in_group("Diagonal"):
			shoot_multiple(4, [-0.785398, 0.785398, -2.35619, 2.35619])
		elif cur_weapon.is_in_group("Spread"):
			shoot_multiple(3, [-0.436332, 0, 0.436332])
		elif cur_weapon.is_in_group("Sides"):
			shoot_multiple(4, [0, PI / 2, PI, 3 * PI / 2])
		elif cur_weapon.is_in_group("Single"):
			var weapon = load(cur_weapon_path).instantiate()
			cur_weapon_stamina.use_up = true
			get_parent().add_child(weapon)
			
		
		
	

func shoot():
	var weapon = load(cur_weapon_path).instantiate()
	weapon.global_position = %ShootingPoint.global_position
	weapon.rotation = rotation
	if weapon.is_in_group("Spiraller") and spiraller_reverse:
		weapon.angle *= -1
		spiraller_reverse = false
	else:
		spiraller_reverse = true
	get_parent().add_child(weapon)

func shoot_multiple(projectiles, angles):
	var weapon
	var angle
	for i in range(projectiles):
		weapon = load(cur_weapon_path).instantiate()
		angle = angles[i]
		weapon.position = position
		weapon.direction = Vector2.RIGHT.rotated(rotation + angle)
		weapon.rotation = rotation + angle
		get_parent().add_child(weapon)
	
func take_damage(damage):
	hurt = true
	%InvincibilityTimer.start()
	$AnimationPlayer.play("Blink")
	health -= damage
	health_changed.emit()
	if health <= 0:
		%InvincibilityTimer.stop()
		dead = true
		var explosion = load("res://Animations/player_explosion.tscn").instantiate()
		explosion.position = position
		get_parent().add_child(explosion)
		await get_tree().create_timer(3).timeout
		queue_free()
		get_tree().change_scene_to_file("res://Levels/game_over.tscn")
	


func _on_area_2d_area_entered(area):
	if area.is_in_group("Enemy") and !hurt:
		take_damage(area.get_parent().damage) # Replace with function body.


func _on_invincibility_timer_timeout():
	hurt = false
