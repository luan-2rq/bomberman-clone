extends KinematicBody2D

var velocity = Vector2(0, 0)

func _physics_process(delta):
	velocity = move_and_slide(velocity)




func _on_Timer_timeout():
	queue_free()
