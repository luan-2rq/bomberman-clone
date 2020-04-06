extends Area2D

func _ready():
	pass

func _on_Timer_timeout():
	print("Fim do timer")
	queue_free()
