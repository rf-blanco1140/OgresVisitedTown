extends CharacterBody2D

const speed = 50
var current_dir = "none"

@onready var all_interactions = []
@onready var interact_label = $InteractionComponents/Panel/InteractLabel

func _ready():
	$AnimatedSprite2D.play("idle_right")
	update_interactions()
	turn_panel_OnOff()

func _physics_process(delta):
	player_movement(delta)
	current_camera()
##	if Input.is_action_just_pressed("interact"):
##		exectute_interactions()

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact"):
		exectute_interactions()

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
	turn_panel_OnOff()
	turn_interactLabel_OnOff()

func _on_interaction_area_area_exited(area):
	all_interactions.erase(area)
	update_interactions()
	turn_panel_OnOff()

func update_interactions():
	if all_interactions:
		interact_label.text = all_interactions[0].interactable_label
	else :
		interact_label.text = ""

func exectute_interactions():
	if all_interactions:
		var curr_intearction = all_interactions[0]
		curr_intearction.interact()
		turn_interactLabel_OnOff()

# Player UI
#########################################################
func turn_interactLabel_OnOff():
	if all_interactions[0].num_interact_total == all_interactions[0].num_interact_curr:
		$InteractionComponents/Panel/InteractLabel.add_theme_color_override("font_color", Color.GRAY)
		print("No Interactions")
	else:
		$InteractionComponents/Panel/InteractLabel.add_theme_color_override("font_color", Color.WHITE)
		print("Yes Interactions!")
func turn_panel_OnOff():
	if all_interactions:
		$InteractionComponents/Panel.visible = true
	else:
		$InteractionComponents/Panel.visible = false
