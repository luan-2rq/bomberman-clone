extends KinematicBody2D
var vel = 200

func _ready():
	set_physics_process(true)

func _process(delta):

	if Input.is_action_just_pressed("ui_right") || Input.is_action_just_pressed("ui_left") || Input.is_action_just_pressed("ui_up") || Input.is_action_just_pressed("ui_down"):
		$stepFX.play()
	elif Input.is_action_just_released("ui_right") || Input.is_action_just_released("ui_left") || Input.is_action_just_released("ui_up") || Input.is_action_just_released("ui_down"):
		$stepFX.stop()
	
	
	
	

func _physics_process(delta):
	var x = 0
	var y = 0
	if Input.is_action_pressed("ui_right"):
		x = 1
	if Input.is_action_pressed("ui_left"):
		x = -1
	if Input.is_action_pressed("ui_up"):
		y = -1
	if Input.is_action_pressed("ui_down"):
		y = 1
	set_position(get_position() + Vector2(vel*x,vel*y)*delta)
