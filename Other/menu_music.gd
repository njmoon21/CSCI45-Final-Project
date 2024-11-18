extends AudioStreamPlayer

const menu_music = preload("res://Audio/Music/[Hotel Dusk_ Room 215] 01 -- Desert Highway.mp3")

func _play_music(music: AudioStream, volume = -12.0):
	if stream == music:
		return
	
	stream = music
	volume_db = volume
	play()

func play_menu_music():
	_play_music(menu_music)
