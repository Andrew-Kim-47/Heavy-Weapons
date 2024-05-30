extends Node2D

#var animation = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Grow")

func shrink():
	$AnimationPlayer.play("Shrink")
	await get_tree().create_timer(1).timeout
	queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
