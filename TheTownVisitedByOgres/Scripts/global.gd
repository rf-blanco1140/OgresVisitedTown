extends Node

var current_sceneID = "secret_entrance" #liminal_road secret_entrance
var transition_scene = false
var nextScene = ""

var player_exit_secretentance_x = 40
var player_exit_secretentance_y = 5
var player_start_x = -40
var player_start_y = -27

var game_first_loadin = true

func finish_changescene(sceneID):
	if transition_scene == true:
		transition_scene = false
		if current_sceneID == "world":
			current_sceneID = "secret_entrance"
		else:
			current_sceneID = "world"
		current_sceneID = sceneID
	global.nextScene = ""
