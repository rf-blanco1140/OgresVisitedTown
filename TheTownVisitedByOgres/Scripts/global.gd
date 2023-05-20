extends Node

var current_scene = "secret_entrance" #world secret_entrance
var transition_scene = false

var player_exit_secretentance_x = 40
var player_exit_secretentance_y = 5
var player_start_x = -40
var player_start_y = -27

var game_first_loadin = true

func finish_changescene():
	if transition_scene == true:
		transition_scene = false
		if current_scene == "world":
			current_scene = "secret_entrance"
		else:
			current_scene = "world"
