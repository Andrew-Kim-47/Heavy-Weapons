extends CharacterBody2D

@export var move_speed : float = 300
@export var fire_delay : float = 0.1
@export var health = 1

var weapon1_path = "res://Weapons/" + Singleton.weapon1 + ".tscn"
var weapon_for_values = load(weapon1_path).instantiate()
var on_cooldown = false
var hurt = false
var dead = false

signal health_changed
@onready var WeaponStamina = get_parent().get_node("CanvasLayer/HUD").get_node("%WeaponStamina")

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
	
	if Input.is_action_pressed("left_click") and %FireDelayTimer.is_stopped() and !WeaponStamina.weapon_on_cooldown:
		%FireDelayTimer.start(weapon_for_values.fire_delay)
		shoot_diagonal()
		
		
	

func shoot():
	var weapon = load(weapon1_path).instantiate()
	weapon.global_position = %ShootingPoint.global_position
	weapon.rotation = rotation
	get_parent().add_child(weapon)

func shoot_diagonal():
	var weapon = load(weapon1_path).instantiate()
	var angle = deg_to_rad(45)
	weapon.position = position
	weapon.direction = Vector2.LEFT.rotated(rotation + angle)
	weapon.rotation = rotation - angle
	get_parent().add_child(weapon)
	weapon = load(weapon1_path).instantiate()
	weapon.position = position
	weapon.direction = Vector2.RIGHT.rotated(rotation + angle)
	weapon.rotation = rotation + angle * 3
	get_parent().add_child(weapon)
	weapon = load(weapon1_path).instantiate()
	weapon.position = position
	weapon.direction = Vector2.UP.rotated(rotation + angle)
	weapon.rotation = rotation + angle
	get_parent().add_child(weapon)
	weapon = load(weapon1_path).instantiate()
	weapon.position = position
	weapon.direction = Vector2.DOWN.rotated(rotation + angle)
	weapon.rotation = rotation - angle * 3
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
