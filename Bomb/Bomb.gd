extends Area2D

var player_owner #O jogador que posicionou a bomba.
var bomb_range #alcance da explosão da bomba
export(PackedScene) var collision_box
#TODO receber o valor de bomb_range do player

var tilemap
var blocks

func _ready():
	pass

func _on_Timer_timeout():
	player_owner.current_player["bombs_capacity"] += 1 
	explosion()	
	queue_free()
	
#Essa função é usada para destruir o player que está fora do tilemap caso ele esteja na área da bomba
func explosion_to_players():
	var raycasts = {
	"up_raycast1" : $RaycastsUp.get_child(0),
	"up_raycast2" : $RaycastsUp.get_child(1),
	"up_raycast3" : $RaycastsUp.get_child(2),
	"bottom_raycast1" : $RaycastsBottom.get_child(0),
	"bottom_raycast2" : $RaycastsBottom.get_child(1),
	"bottom_raycast3" : $RaycastsBottom.get_child(2),
	"right_raycast1" : $RaycastsRight.get_child(0),
	"right_raycast2" : $RaycastsRight.get_child(1),
	"right_raycast3" : $RaycastsRight.get_child(2),
	"left_raycast1" : $RaycastsLeft.get_child(0),
	"left_raycast2" : $RaycastsLeft.get_child(1),
	"left_raycast3" : $RaycastsLeft.get_child(2)
	}
	
	for i in range(raycasts.size()):	
		if raycasts.values()[i].is_colliding():			
			#Verificando se um player foi atingido pelo raycast
			if raycasts.values()[i].get_collider().is_in_group("player"):
				#Destruímos o personagem na linha abaixo
				raycasts.values()[i].get_collider().queue_free()
		i += 1
#Essa função é usada para destruir blocos que estão dentro do tilemap caso eles estejam na área da bomba
func explosion_to_blocks():
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
	
func explosion():
	explosion_to_players()
	explosion_to_blocks()

func _on_Bomb_body_exited(_body):
	call_deferred("add_collider")
	
func add_collider():
	self.add_child(collision_box.instance())
	
