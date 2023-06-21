class_name Interactable extends Area2D

@export var interactable_label = "none"
@export var dialog_resoruce : DialogueResource
@export var dialog_start = "first_intearction" ## "second_intearction" "third_intearction" "fourth_intearction" "fifth_intearction"
@export var num_interact_total = 1
@export var num_interact_curr = 0
@export var external_listener : Node2D

@export var sprite : SpriteFrames
@export var idle_anim_ID = "none"
@export var listening_anim_ID = "none"

func _ready():
	if(idle_anim_ID != "none"):
		$NPC_Static.set_animatedSprite(sprite)
		$NPC_Static.set_idle_ID(idle_anim_ID)
		$NPC_Static.set_listening_ID(listening_anim_ID)
		$NPC_Static.start_idle_anim()

func interact() -> void:
	if num_interact_curr == 0:
		num_interact_curr += 1
	elif num_interact_curr < num_interact_total:
		if num_interact_curr == 1:
			dialog_start = "second_intearction"
		elif num_interact_curr == 2:
			dialog_start = "third_intearction"
		elif num_interact_curr == 3:
			dialog_start = "fourth_intearction"
		elif num_interact_curr == 4:
			dialog_start = "fifth_intearction"
		num_interact_curr += 1
	global.register_Interaction(self)
	if(external_listener):
		external_listener.startListeningInteraction()
	DialogueManager.show_example_dialogue_balloon(dialog_resoruce, dialog_start)
	$AudioStreamPlayer2D.play()

func unsubscribeListeners():
	if(external_listener):
		external_listener.stopListeningInteraction()

func stopListeningInteraction():
	if(idle_anim_ID != "none"):
		$NPC_Static.stopListeningInteraction()

func startListeningInteraction():
	if(idle_anim_ID != "none"):
		$NPC_Static.startListeningInteraction()
