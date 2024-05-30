class_name Enemy extends CharacterBody2D

@onready var player = get_parent().get_node("Player")
var drop = preload("res://Characters/small_drop.tscn").instantiate()
var health = 100
var speed = 200
var player_position
var damage = 15
signal health_changed


func _physics_process(delta):
	velocity = (player.position - position).normalized() * speed
	move_and_slide()
	look_at(player.position)
	

func take_damage(damage):
	
	health -= damage
	health_changed.emit()
	if health <= 0:
		drop.position = position
		get_parent().add_child(drop)
		get_parent().kill_enemy()
		queue_free()


func _on_area_2d_area_entered(area):
	if area.is_in_group("Weapon") and !area.used: #Check if is weapon and hasn't already hit something else
		area.used = true
		take_damage(area.damage)
		area.queue_free()
