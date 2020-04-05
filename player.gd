extends KinematicBody2D
var speed = 200
var velocity = Vector2(0, 0)
var bomb = preload("res://bomb.tscn")
var allowedBombPlacing = true
	
	
func _ready():
	set_physics_process(true)
		

func _process(delta):

	if Input.is_action_just_pressed("ui_right") || Input.is_action_just_pressed("ui_left") || Input.is_action_just_pressed("ui_up") || Input.is_action_just_pressed("ui_down"):
		$stepFX.play()
		
	elif Input.is_action_just_released("ui_right") || Input.is_action_just_released("ui_left") || Input.is_action_just_released("ui_up") || Input.is_action_just_released("ui_down"):
		$stepFX.stop()
		
	if Input.is_action_pressed("ui_accept") && allowedBombPlacing:
		var bomb_instance = bomb.instance()
		bomb_instance.position = self.position
		get_parent().add_child(bomb_instance)
		allowedBombPlacing = false

func _physics_process(delta):
	velocity.x = 0
	velocity.y = 0
	if Input.is_action_pressed("ui_right"):
		velocity.x += speed
	if Input.is_action_pressed("ui_left"):
		velocity.x -= speed
	if Input.is_action_pressed("ui_up"):
		velocity.y -= speed
	if Input.is_action_pressed("ui_down"):
		velocity.y += speed
	velocity = move_and_slide(velocity, Vector2(0, -1))
	
	
