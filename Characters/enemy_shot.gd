class_name Projectile extends Area2D

@onready var player = get_parent().get_node("Player")
var damage = 15
var direction
var speed = 100
var original_speed = 100

func _physics_process(delta):
	position += direction * speed * delta
	if get_parent().slow_time:
		speed = original_speed * 0.2
	else:
		speed = original_speed


func _on_area_entered(area):
	if area.is_in_group("Player") and !player.hurt:
		queue_free()
