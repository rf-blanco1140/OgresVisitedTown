extends CharacterBody2D

const speed = 50
var current_dir = "none"
var isMoving = false

@onready var all_interactions = []
@onready var interact_label = $InteractionComponents/Panel/InteractLabel

func _ready():
	$AnimatedSprite2D.play("idle_right")
	update_interactions()
	turn_panel_OnOff()
	current_camera()

func _physics_process(delta):
	player_movement(delta)
##	if Input.is_action_just_pressed("interact"):
##		exectute_interactions()

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact"):
		exectute_interactions()

func player_movement(delta):
	if Input.is_action_pressed("ui_right"):
		current_dir = "right"
		isMoving = true
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		current_dir = "left"
		isMoving = true
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		current_dir = "down"
		isMoving = true
		velocity.y = speed
		velocity.x = 0
	elif Input.is_action_pressed("ui_up"):
		current_dir = "up"
		isMoving = true
		velocity.y = -speed
		velocity.x = 0
	else:
		isMoving = false
		velocity.y = 0
		velocity.x = 0
	play_anim()
	move_and_slide()

func play_anim():
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if isMoving == false:
		match dir:
			"right":
				anim.play("idle_right")
			"left":
				anim.play("idle_left")
			"down":
				anim.play("idle_front")
			"up":
				anim.play("idle_back")
	elif isMoving == true:
		match dir:
			"right":
				anim.play("walk_right")
			"left":
				anim.play("walk_left")
			"down":
				anim.play("walk_front")
			"up":
				anim.play("walk_back")

func current_camera():
	if global.current_sceneID == "liminal_road":
		$world_camera.enabled = true
		$sec_entrance_camera.enabled = false
	if global.current_sceneID == "secret_entrance":
		$world_camera.enabled = false
		$sec_entrance_camera.enabled = true
	
	#$Camera2D.limit_left = global.camera_map_limits.position.x * global.camera_map_cellsize.x
	#$Camera2D.limit_right = global.camera_map_limits.end.x * global.camera_map_cellsize.x
	#$Camera2D.limit_left = global.camera_map_limits.position.y * global.camera_map_cellsize.y
	#$Camera2D.limit_left = global.camera_map_limits.end.y * global.camera_map_cellsize.y
	
	$sec_entrance_camera.enabled = false
	$world_camera.enabled = false
	$Camera2D.enabled = true

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


func _on_animated_sprite_2d_frame_changed():
	pass
	#if isMoving:
		#match $AnimatedSprite2D.frame:
			#0, 2:
				#$AudioStreamPlayer2D.play()
