class_name Weapon extends Area2D

@export var speed = 700
@export var damage = 75
var travelled_distance = 0
const RANGE = 700
var direction 
var cooldown_ = 3
var recharge_speed
var full_recharge_speed
var fire_delay = 0.1

var used = false #Boolean to make sure only one enemy gets hit

func _ready():
	direction = Vector2.RIGHT.rotated(rotation)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction * speed * delta
	travelled_distance += speed * delta
	if travelled_distance > RANGE:
		queue_free()
	

