extends Area2D
var songs = ["secret_level", "tutorial_tower", "floor_plaza", "sea_tower", "world_map", "techno_tower"]

func _ready():
    if !AudioManager.music.playing || AudioManager.current_music.to_lower() != "tutorial_tower": AudioManager.change_song(songs[AudioManager.music_index])

func rotate_music():
    AudioManager.music_index += 1
    if AudioManager.music_index >= len(songs): return 0
    if AudioManager.music_index < 0: return len(songs)-1
    return AudioManager.music_index

func change_music():    
    AudioManager.music_index = rotate_music()
    AudioManager.change_song(songs[AudioManager.music_index])
