class_name Interactable extends Area2D


@export var interactable_label = "none"
@export var dialog_resoruce : DialogueResource
@export var dialog_start = "first_intearction"
@export var num_interact_total = 1
@export var num_interact_curr = 0

func interact() -> void:
	if num_interact_curr < num_interact_total:
		DialogueManager.show_example_dialogue_balloon(dialog_resoruce, dialog_start)
