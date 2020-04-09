extends Area2D

var player_owner #O jogador que posicionou a bomba.
var bomb_range = 4 #alcance da explosão da bomba
#TODO receber o valor de bomb_range do player
var tilemap
var blocks

var player_is_in_bomb_area
var players_in_bomb_area = []

func _ready():
	set_bomb_range(bomb_range)

func set_bomb_range(bomb_range):
	var bomb_collision_x_axis = $bomb_range_area.get_child(0)
	var bomb_collision_y_axis = $bomb_range_area.get_child(1)
	bomb_collision_x_axis.scale = Vector2(1 + 2 * bomb_range, 1)
	bomb_collision_y_axis.scale = Vector2(1, 1 + 2 * bomb_range)

#Essa função mata os playes que estão na área de alcance da bomba
func kill_players(var players_to_kill):
	if player_is_in_bomb_area:
		for x in range(players_to_kill.size()):
			players_to_kill[x].queue_free()

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

func _on_bomb_range_area_body_entered(body):
	if body.is_in_group("player"):
		player_is_in_bomb_area = true
		players_in_bomb_area.append(body)

func _on_bomb_range_area_body_exited(body):
	if body.is_in_group("player"):
		player_is_in_bomb_area = false
		players_in_bomb_area.erase(body)

func _on_Timer_timeout():
	var players_to_kill = players_in_bomb_area
	kill_players(players_to_kill)
	explosion()
	queue_free()
	#Falta fazer com que o player perca bombas, com o código abaixo tá crashando
	#player_owner.current_player["bombs_capacity"] += 1
