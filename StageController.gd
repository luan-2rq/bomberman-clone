extends Node2D

onready var background_tile = preload("res://backgroud_tile.tscn")
onready var unbreakable_tile = preload("res://unbreakable_block.tscn")

onready var board_length = 15
onready var board_heigth = 11
onready var board_area = board_length * board_heigth
onready var tile_size = 55

onready var board_border_length = board_length + 2
onready var board_border_heigth = board_heigth + 2
onready var board_border_size = 2 * board_border_length +  2 * board_heigth
onready var unbreakable_tile_position = Vector2(135, 27.6)
onready var background_tile_position = Vector2(190, 82.6)

func _ready():
	var background_tile_node
	var unbreakable_tile_node
	var backgroud_initial_position_x = background_tile_position.x
	
	#instancing the border unbreakable tiles
	for n in range(board_border_size):
		if n < board_border_length:
			unbreakable_tile_position.x = unbreakable_tile_position.x + tile_size
			unbreakable_tile_node = unbreakable_tile.instance()
			unbreakable_tile_node.position = unbreakable_tile_position
			self.get_child(0).add_child(unbreakable_tile_node)
			
		if n >= board_border_length and n < board_border_length + board_border_heigth - 1:
			unbreakable_tile_position.y = unbreakable_tile_position.y + tile_size
			unbreakable_tile_node = unbreakable_tile.instance()
			unbreakable_tile_node.position = unbreakable_tile_position
			self.get_child(0).add_child(unbreakable_tile_node)
			
		if n >= board_border_length + board_border_heigth - 1 and n < (2 * board_border_length) - 1 + board_border_heigth - 1 :
			unbreakable_tile_position.x = unbreakable_tile_position.x - tile_size
			unbreakable_tile_node = unbreakable_tile.instance()
			unbreakable_tile_node.position = unbreakable_tile_position
			self.get_child(0).add_child(unbreakable_tile_node)
			
		if n >= (2 * board_border_length) - 1 + board_border_heigth - 1  and n < board_border_size :
			unbreakable_tile_position.y = unbreakable_tile_position.y - tile_size
			unbreakable_tile_node = unbreakable_tile.instance()
			unbreakable_tile_node.position = unbreakable_tile_position
			self.get_child(0).add_child(unbreakable_tile_node)
			
	#instancing the backgroud tiles
	for n in range(board_area):
		background_tile_position.x = background_tile_position.x + tile_size
		background_tile_node = background_tile.instance()
		background_tile_node.position = background_tile_position
		self.get_child(1).add_child(background_tile_node)
		
		if (n + 1) % board_length == 0:
			background_tile_position.y = background_tile_position.y + tile_size
			background_tile_position.x = backgroud_initial_position_x
				
