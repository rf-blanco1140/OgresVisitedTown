extends Node2D

var mySceneID = "secret_entrance"

# Called when the node enters the scene tree for the first time.
func _ready():
	if global.game_first_loadin == true:
		$player.position.x = global.player_start_x
		$player.position.y = global.player_start_y
		MusicController.play_music()
		
	else:
		$player.position.x = global.player_exit_secretentance_x
		$player.position.y = global.player_exit_secretentance_y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_scene()


func _on_sec_entrance_exit_point_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true
		global.nextScene = "res://Scenes/world.tscn"

func _on_sec_entrance_exit_point_body_exited(body):
	if body.has_method("player"):
		global.transition_scene = false

func change_scene():
	if global.transition_scene == true:
		if global.current_sceneID == "secret_entrance":
			get_tree().change_scene_to_file(global.nextScene)
			global.game_first_loadin = false
			global.finish_changescene("liminal_road")
