extends KinematicBody2D

export (float) var speed = 200
export (float) var gravity = 1000
export (float) var jump_force = 500
export (PackedScene) var bullet

var velocity = Vector2(0, 0)
var is_jumping = false
var facing = 1

func _physics_process(delta):

	velocity.x = 0

	if Input.is_action_pressed("ui_left"): 
		velocity.x -= speed 
		facing = -1
		
	if Input.is_action_pressed("ui_right"):
		velocity.x += speed
		facing = 1
		
		
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		is_jumping = true
		velocity.y = -jump_force
	
	if is_jumping and Input.is_action_just_released("ui_up") and velocity.y <= 0:
		velocity.y = 0
		is_jumping = false
		
	if is_jumping and velocity.y >= 0:
		is_jumping = false
		
	if Input.is_action_just_pressed("ui_select"):
		var bullet_node = bullet.instance()
		bullet_node.velocity = Vector2(500, 0)*facing
		bullet_node.position = position
		get_parent().add_child(bullet_node)
		
	velocity.y += gravity*delta
	velocity = move_and_slide(velocity, Vector2(0, -1))

	print(velocity)
