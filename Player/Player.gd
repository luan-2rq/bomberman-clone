extends KinematicBody2D

export (int) var player_id
var current_player
export var speed = 64
export var initial_bombs_capacity = 5

export (Resource) var current_player_sprite

export (PackedScene) var pre_load_bomb
#export var bombs_size = 5

#controles para o player 0
var player_0 = {
	"spawn_point": "SpawnPlayer0",
	"walk_down": "walk_down",
	"walk_up": "walk_up",
	"walk_right": "walk_right",
	"walk_left": "walk_left",
	"drop_bomb": "drop_bomb",
}

#controles alternativos para o player 1
var player_1 = {
	"spawn_point": "SpawnPlayer1",
	"walk_down": "walk_down_alt",
	"walk_up": "walk_up_alt",
	"walk_right": "walk_right_alt",
	"walk_left": "walk_left_alt",
	"drop_bomb": "drop_bomb_alt",
}

func _ready():
	get_and_spawn_current_player() #Atribui os inputs para o jogador de acordo com o player_id e os posiciona no ponto de spawn
	position = get_parent().get_node(current_player.spawn_point).position
	$AnimatedSprite.frames = current_player_sprite

func _physics_process(delta): #Executada a cada frame para identificar o movimento do jogador.
	var velocity = Vector2() 

	if Input.is_action_pressed(current_player.walk_down):
		velocity.y += 1
	
	if Input.is_action_pressed(current_player.walk_up):
		velocity.y -= 1
	
	if Input.is_action_pressed(current_player.walk_right):
		velocity.x += 1
	
	if Input.is_action_pressed(current_player.walk_left):
		velocity.x -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.animation = "down"
		$AnimatedSprite.stop()
	
	if velocity.y > 0:
		$AnimatedSprite.animation = "down"
	elif velocity.y < 0:
		$AnimatedSprite.animation = "up"
	elif velocity.x > 0:
		$AnimatedSprite.animation = "right"
	elif velocity.x < 0:
		$AnimatedSprite.animation = "left"
	
	move_and_slide(velocity)

func get_and_spawn_current_player():
	if player_id == 0:
		current_player = player_0
	elif player_id == 1:
		current_player = player_1
	current_player["bombs_capacity"] = initial_bombs_capacity

func _input(event):
	if Input.is_action_pressed(current_player.drop_bomb) and current_player.bombs_capacity > 0:
		spawn_bomb()
		current_player.bombs_capacity -= 1

func spawn_bomb():
	var bomb = pre_load_bomb.instance()
	var bomb_position = get_tilemap().world_to_map(position) * get_tilemap().get_cell_size()
	
	bomb.set_position(bomb_position)
	get_parent().add_child(bomb)
	
	bomb.player_owner = get_parent().get_node(name)
	bomb.tilemap = get_tilemap()
	bomb.blocks = get_blocks()
	bomb.z_index = 1

func get_tilemap():
	for node in get_parent().get_children():
		if node is TileMap:
			return(node)

func get_blocks():
	for node in get_tilemap().get_children():
		if node is TileMap:
			return(node)
