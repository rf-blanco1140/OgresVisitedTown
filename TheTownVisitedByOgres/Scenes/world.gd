extends Node2D

var mySceneID = "liminal_road"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_scene()

func change_scene():
	if global.transition_scene == true:
		get_tree().change_scene_to_file(global.nextScene)
		global.finish_changescene("secret_entrance")
		global.nextScene = ""

func _on_secret_entrance_transition_point_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true
		global.nextScene = "res://Scenes/secret_entrance.tscn"

func _on_secret_entrance_transition_point_body_exited(body):
	if body.has_method("player"):
		global.transition_scene = false

func _on_town_center_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true
		global.nextScene = "res://Scenes/new_town.tscn"

func _on_town_center_body_exited(body):
	if body.has_method("player"):
		global.transition_scene = false
