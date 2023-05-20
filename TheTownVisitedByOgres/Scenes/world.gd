extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_scene()


func _on_secret_entrance_transition_point_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true


func _on_secret_entrance_transition_point_body_exited(body):
	if body.has_method("player"):
		global.transition_scene = false

func change_scene():
	if global.transition_scene == true:
		if global.current_scene == "world":
			print(":3")
			get_tree().change_scene_to_file("res://Scenes/secret_entrance.tscn")
			global.finish_changescene()
