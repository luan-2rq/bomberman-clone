extends StaticBody2D


onready var timer = get_child(2)
func _ready():
	timer.set_wait_time(3)
	timer.start()

func _on_Timer_timeout():
	queue_free()
