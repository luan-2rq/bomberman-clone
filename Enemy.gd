extends Area2D

func _on_Enemy_body_entered(body):
	if body.is_in_group("player"):
		get_tree().reload_current_scene()
		print("djsj")
		
	if body.is_in_group("bullet"):
		queue_free()
		body.queue_free()
