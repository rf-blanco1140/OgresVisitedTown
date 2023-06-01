extends Node

var current_sceneID = "secret_entrance" #liminal_road secret_entrance
var transition_scene = false
var nextScene = ""

var camera_map_limits
var camera_map_cellsize

var game_first_loadin = true

func finish_changescene(sceneID):
	if transition_scene == true:
		transition_scene = false
		
		current_sceneID = sceneID
	global.nextScene = ""
