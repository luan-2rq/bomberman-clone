extends Area2D

var player_owner #O jogador que posicionou a bomba.
var bomb_range = 3 #alcance da explosão da bomba
#TODO receber o valor de bomb_range do player

var tilemap
var blocks

func _ready():
	pass

func _on_Timer_timeout():
	player_owner.current_player["bombs_capacity"] += 1
	explosion()
	queue_free()

func explosion():
	var position_in_tilemap = position / tilemap.get_cell_size()
	
	var can_explode = {
		"down": true,
		"up": true,
		"right": true,
		"left": true
	}
	
	for i in range(bomb_range):
		i += 1

		var bomb_axis = {
			"down": Vector2(position_in_tilemap.x, position_in_tilemap.y + i),
			"up": Vector2(position_in_tilemap.x, position_in_tilemap.y - i),
			"right": Vector2(position_in_tilemap.x + i, position_in_tilemap.y),
			"left": Vector2(position_in_tilemap.x - i, position_in_tilemap.y)
		}
		
		for j in range(bomb_axis.size()):

			var actual_axis = bomb_axis.keys()[j]
			var tile_position = bomb_axis.values()[j]
			
			var tile_id = tilemap.get_cell(tile_position.x, tile_position.y)
			
			var is_wall = (tilemap.get_tileset().tile_get_shape_count(tile_id) != 0) #ERRO: devolve falso para tile de blocks. Deveria devolver verdadeiro.
			
			var is_block = (blocks.get_cell(tile_position.x, tile_position.y) != -1)
			
			if (is_wall or is_block) and can_explode[actual_axis]:
				can_explode[actual_axis] = false
				if is_block:
					blocks.set_cell(tile_position.x, tile_position.y, -1)
