extends Node2D

var idle_anim_ID = "none"
var listening_anim_ID = "none"

func start_idle_anim():
	$AnimatedSprite2D.play(idle_anim_ID)

func set_idle_ID(pID):
	idle_anim_ID = pID

func set_listening_ID(pID):
	listening_anim_ID = pID

func set_animatedSprite(pSprite):
	$AnimatedSprite2D.sprite_frames = pSprite

func stopListeningInteraction():
	if(idle_anim_ID != "none"):
		$AnimatedSprite2D.play(idle_anim_ID)

func startListeningInteraction():
	if(idle_anim_ID != "none"):
		$AnimatedSprite2D.play(listening_anim_ID)
		
