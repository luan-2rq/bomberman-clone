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
	var r = 0
	var l = 0
	var u = 0
	var d = 0
	
	if Input.is_action_pressed("ui_right"):
		r = 1
	if Input.is_action_pressed("ui_left"):
		l = -1
	if Input.is_action_pressed("ui_up"):
		u = -1
	if Input.is_action_pressed("ui_down"):
		d = 1
	set_position(get_position() + Vector2(vel*(r+l),vel*(u+d))*delta)
