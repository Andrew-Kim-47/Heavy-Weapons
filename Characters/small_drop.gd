extends Area2D




func _on_area_entered(area):
	if area.is_in_group("Player"):
		get_parent().cash += 1
		queue_free()
	 # Replace with function body.
