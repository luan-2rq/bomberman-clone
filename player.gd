extends KinematicBody2D
var speed = 200
var velocity = Vector2(0, 0)
var bomb = preload("res://bomb.tscn")
var allowedBombPlacing = true
#the raycast must receive this variable to know where to point
var facing = Vector2(0, 0)
onready var timer = get_parent().get_node("Timer")

func _ready():
	set_physics_process(true)
	timer.set_wait_time(1)
	timer.start()

func _process(delta):
	if $pointer.is_colliding():
			print("eu")
			
	if Input.is_action_pressed("ui_accept") && allowedBombPlacing:
		if $pointer.is_colliding():
			if $pointer.get_collider().is_in_group("bomb"):
				allowedBombPlacing = false
			if $pointer.get_collider().is_in_group("background_tile") && allowedBombPlacing:
				var bomb_node = bomb.instance()
				bomb_node.position = $pointer.get_collider().position
				get_parent().add_child(bomb_node)
				allowedBombPlacing = false
			
	

func _physics_process(delta):
	velocity.x = 0
	velocity.y = 0
	if Input.is_action_pressed("ui_right"):
		velocity.x += speed
		facing = Vector2(55, 0)
		$Sprite/AnimationPlayer.play("move_right")
	if Input.is_action_pressed("ui_left"):
		velocity.x -= speed
		facing = Vector2(-55, 0)
		$Sprite/AnimationPlayer.play("move_left")
	if Input.is_action_pressed("ui_up"):
		velocity.y -= speed
		facing = Vector2(0, 55)
		$Sprite/AnimationPlayer.play("move_up")
	if Input.is_action_pressed("ui_down"):
		velocity.y += speed
		facing = Vector2(0, -55)
		$Sprite/AnimationPlayer.play("move_down")
	velocity = move_and_slide(velocity, Vector2(0, -1))
	#implementing the direction the raycast will aim
	$pointer.cast_to = facing
	
func _on_Timer_timeout():
	allowedBombPlacing = true
