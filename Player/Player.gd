extends KinematicBody2D

export (int) var player_id
var current_player
export var speed = 64

#controles para o player 0
var player_0 = {
	"walk_down": "walk_down",
	"walk_up": "walk_up",
	"walk_right": "walk_right",
	"walk_left": "walk_left"
}

#controles alternativos para o player 1
var player_1 = {
	"walk_down": "walk_down_alt",
	"walk_up": "walk_up_alt",
	"walk_right": "walk_right_alt",
	"walk_left": "walk_left_alt"
}

func _ready():
	get_current_player() #Atribui os inputs para o jogador de acordo com o player_id.

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
	
	move_and_slide(velocity)

func get_current_player():
	if player_id == 0:
		current_player = player_0
	elif player_id == 1:
		current_player = player_1
