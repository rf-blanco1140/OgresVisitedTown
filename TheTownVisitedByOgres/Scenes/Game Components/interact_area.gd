class_name Interactable extends Area2D


@export var interactable_label = "none"
@export var dialog_resoruce : DialogueResource
@export var dialog_start = "first_intearction"

func interact() -> void:
	DialogueManager.show_example_dialogue_balloon(dialog_resoruce, dialog_start)
