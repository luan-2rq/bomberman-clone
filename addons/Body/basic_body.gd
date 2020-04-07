tool
extends KinematicBody2D


var collides = 0 #determina se o objeto colide com outros ou não.
var weight = 0 #poder necessario para levantar e jogar o objeto.
var health = 3 #todo objeto tem um valor de vida. quando este chega a zero, a função que destroi o objeto é chamada. (se for bomba explode, etc.)

func _enter_tree():
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
