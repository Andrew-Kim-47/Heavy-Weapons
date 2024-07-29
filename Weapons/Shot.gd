class_name Weapon extends Area2D

@export var speed = 700
@export var damage = 75

@onready var map = get_parent()


var max_damage
var travelled_distance = 0
var range = 700
var direction 

var cooldown_step_size = 0.2
var recharge_speed = 0.3
var full_recharge_speed = 0.45
var fire_delay = 0.1

var one_shot_recharged = true
var used = false #Boolean to make sure only one enemy gets hit

func _ready():
	direction = Vector2.RIGHT.rotated(rotation)
	max_damage = damage

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position += direction * speed * delta
	travelled_distance += speed * delta
	if travelled_distance > range:
		queue_free()
	
func hit(enemy_health):
	if enemy_health >= max_damage:
		queue_free()
	else:
		used = false
		max_damage -= enemy_health
