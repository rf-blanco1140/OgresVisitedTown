extends Node2D

var mySceneID = "secret_entrance"
var player_exit_secretentance_x = 40
var player_exit_secretentance_y = 5
var player_start_x = -40
var player_start_y = -27

# Called when the node enters the scene tree for the first time.
func _ready():
	if global.game_first_loadin == true:
		$player.position.x = player_start_x
		$player.position.y = player_start_y
		MusicController.play_music()
		
	else:
		$player.position.x = player_exit_secretentance_x
		$player.position.y = player_exit_secretentance_y
	
	var camera_map_cellsize = $TileMap.cell_quadrant_size
	var camera_map_limits = $TileMap.get_used_rect()
	var player_camera = get_node("player/Camera2D")
	player_camera.limit_left = camera_map_limits.position.x * camera_map_cellsize
	player_camera.limit_right = camera_map_limits.end.x * camera_map_cellsize
	player_camera.limit_top = camera_map_limits.position.y * camera_map_cellsize
	player_camera.limit_bottom = camera_map_limits.end.y * camera_map_cellsize


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
