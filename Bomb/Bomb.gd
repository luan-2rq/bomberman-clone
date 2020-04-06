extends Area2D

var player_owner #O jogador que posicionou a bomba.

func _ready():
	pass

func _on_Timer_timeout():
	player_owner.current_player["bombs_capacity"] += 1
	explosion()
	queue_free()

func explosion(): #TODO fazer com que a bomba interaja com o TileMap
	pass
