extends Node2D


# Called when the node enters the scene tree for the first time.
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
	pass
