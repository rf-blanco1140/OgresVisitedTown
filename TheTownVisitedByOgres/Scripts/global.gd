extends Node

var current_sceneID = "secret_entrance" #liminal_road secret_entrance
var transition_scene = false
var nextScene = ""

var camera_map_limits
var camera_map_cellsize

var game_first_loadin = true
var registered_interaction

func finish_changescene(sceneID):
	if transition_scene == true:
		transition_scene = false
		
		current_sceneID = sceneID
	global.nextScene = ""

func notify_RegisteredInteraction_Ended():
	registered_interaction.unsubscribeListeners()

func register_Interaction(pInteraction):
	registered_interaction = pInteraction
