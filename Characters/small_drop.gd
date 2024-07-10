extends Area2D


func _physics_process(_delta):
	%Shadow.global_position = global_position + Vector2(0, 6)
	%Shadow.rotation = 0
	$AnimationPlayer.play("Idle")

func _on_area_entered(area):
	if area.is_in_group("Player"):
		get_parent().cash += 1
		queue_free()
	 # Replace with function body.
