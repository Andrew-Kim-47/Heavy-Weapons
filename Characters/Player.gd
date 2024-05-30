extends CharacterBody2D

@export var move_speed : float = 300
@export var fire_delay : float = 0.1
@export var health = 1
var weapon_for_values = preload("res://Weapons/shot.tscn").instantiate()
var on_cooldown = false
var hurt = false

signal health_changed
@onready var WeaponStamina = get_parent().get_node("CanvasLayer/HUD/HBoxContainer/Weapon1/WeaponStamina")

func _physics_process(_delta):
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
		shoot()
		
		
	

func shoot():
	var weapon = preload("res://Weapons/shot.tscn").instantiate()
	weapon.global_position = %ShootingPoint.global_position
	weapon.rotation = rotation
	get_parent().add_child(weapon)
	
func take_damage(damage):
	hurt = true
	%InvincibilityTimer.start()
	$AnimationPlayer.play("Blink")
	health -= damage
	health_changed.emit()
	if health <= 0:
		queue_free()
		get_tree().change_scene_to_file("res://Levels/game_over.tscn")
	


func _on_area_2d_area_entered(area):
	if area.is_in_group("Enemy") and !hurt:
		take_damage(area.get_parent().damage) # Replace with function body.


func _on_invincibility_timer_timeout():
	hurt = false
