tool
extends EditorPlugin


func _enter_tree():
	
	add_custom_type("Basic_Body", "KinematicBody2D", preload("basic_body.gd"), preload("icon2.png"))
	pass


func _exit_tree():
	remove_custom_type("Basic_Body")
	pass
