extends Node

@export var mute : bool = false
@onready var music = $Music
var sfx_muted = false

var current_music : String
var music_index = 0

##################################################### MUSICA ################################
func change_song(new_music:String):

	if current_music != new_music:
		current_music = new_music
		music.stream = load("res://music/" + new_music + ".ogg")
		if !mute: music.play()
	else:
		return

func mute_music():
	if !mute: 
		music.playing = false
		mute = true
		
	else: 
		music.playing = true
		mute = false


func mute_sfx():
	if !sfx_muted: 
		AudioServer.set_bus_mute(2, true)
		sfx_muted = true

	else:
		AudioServer.set_bus_mute(2, false)
		sfx_muted = false
		play_dialogue_sound()
	
############################################### SONIDOS DEL JUGADOR ################################
func play_jump() -> void:
	if !sfx_muted: $Jump.play()

func play_get_floor() -> void:
	if !sfx_muted: $GetFloor.play()

func play_shoot() -> void:
	if !sfx_muted: $Shoot.play()

func play_take_damage() -> void:
	if !sfx_muted: $TakeDamage.play()

func play_explosion() -> void:
	if !sfx_muted: $Explosion.play()

func play_grab_object() -> void:
	if !sfx_muted: $GrabObject.play()

func play_drop_object() -> void:
	if !sfx_muted: $DropObject.play()
	
func play_swap_floor() -> void:
	if !sfx_muted: $SwapFloor.play()

func play_inavlid_action() -> void:
	if !sfx_muted: $InvalidAction.play()

func play_dialogue_sound():
	if !sfx_muted: $DialogueSound.play()
	
func play_water_splash():
	if !sfx_muted: $WaterSplash.play()

func play_chomp():
	if !sfx_muted: $Chomp.play()

func play_earthquake():
	if !sfx_muted: $Earthquake.play()

func play_bird_flight():
	if !sfx_muted: $BirdFlight.play()

############################################### SONIDOS DE OBJETOS ################################
func play_bullet_shot():
	if !sfx_muted: $BulletShoot.play()
	
func play_box_explode():
	if !sfx_muted: $BoxExplode.play()

func play_button_press():
	if !sfx_muted: $ButtonPress.play()

############################################### SONIDOS DEL MAPA ################################
func play_map_zone_notification():
	if !sfx_muted: $MapZoneNotification.play()

################################################### OTROS #######################################
func play_peek():
	if !sfx_muted: $Peek.play()
