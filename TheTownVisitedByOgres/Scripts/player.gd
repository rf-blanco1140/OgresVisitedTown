extends CharacterBody2D

const speed = 50
var current_dir = "none"

@onready var all_interactions = []
@onready var interact_label = $InteractionComponents/InteractLabel

func _ready():
	$AnimatedSprite2D.play("idle_right")
	update_interactions()

func _physics_process(delta):
	player_movement(delta)
	current_camera()
	if Input.is_action_just_pressed("interact"):
		exectute_interactions()
		DialogueManager.show_example_dialogue_balloon(load("res://Dialogs/NoReturn.dialogue"))
		return

func player_movement(delta):
	if Input.is_action_pressed("ui_right"):
		current_dir = "right"
		play_anim(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		current_dir = "left"
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		current_dir = "down"
		play_anim(1)
		velocity.y = speed
		velocity.x = 0
	elif Input.is_action_pressed("ui_up"):
		current_dir = "up"
		play_anim(1)
		velocity.y = -speed
		velocity.x = 0
	else:
		play_anim(0)
		velocity.y = 0
		velocity.x = 0
	
	move_and_slide()

func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if dir == "right":
		if movement == 1:
			anim.play("walk_right")
		elif movement == 0:
			anim.play("idle_right")
	if dir == "left":
		if movement == 1:
			anim.play("walk_left")
		elif movement == 0:
			anim.play("idle_left")
	if dir == "down":
		if movement == 1:
			anim.play("walk_front")
		elif movement == 0:
			anim.play("idle_front")
	if dir == "up":
		if movement == 1:
			anim.play("walk_back")
		elif movement == 0:
			anim.play("idle_back")

func current_camera():
	if global.current_scene == "world":
		$world_camera.enabled = true
		$sec_entrance_camera.enabled = false
	if global.current_scene == "secret_entrance":
		$world_camera.enabled = false
		$sec_entrance_camera.enabled = true

func player():
	pass

# Interactions Methods
#######################################################
func _on_interaction_area_area_entered(area):
	all_interactions.insert(0, area)
	update_interactions()

func _on_interaction_area_area_exited(area):
	all_interactions.erase(area)
	update_interactions()

func update_interactions():
	if all_interactions:
		interact_label.text = all_interactions[0].interactable_label
	else :
		interact_label.text = ""

func exectute_interactions():
	if all_interactions:
		var curr_intearction = all_interactions[0]
		match curr_intearction.interactable_type:
			"print_text" : print(curr_intearction.interactable_value)
