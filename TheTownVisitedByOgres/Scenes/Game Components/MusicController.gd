extends Node

var bg_music = load("res://Sounds/Desert Town (Loop).wav")

func play_music():
	$Music.stream = bg_music
	$Music.play()
