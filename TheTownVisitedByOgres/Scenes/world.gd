extends Node2D

var mySceneID = "liminal_road"

func _ready():
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
		global.nextScene = "res://Scenes/town_center.tscn"

func _on_town_center_body_exited(body):
	if body.has_method("player"):
		global.transition_scene = false
