extends Node

@export var mute : bool = false
@onready var music = $Music

var current_music : String

##################################################### MUSICA ################################
func change_song(new_music:String):

	if current_music != new_music:
		current_music = new_music
		music.stream = load("res://music/" + new_music + ".ogg")
		if !mute: music.play()
	else:
		return

############################################### SONIDOS DEL JUGADOR ################################
func play_jump() -> void:
	if !mute: $Jump.play()

func play_get_floor() -> void:
	if !mute: $GetFloor.play()

func play_shoot() -> void:
	if !mute: $Shoot.play()

func play_take_damage() -> void:
	if !mute: $TakeDamage.play()

func play_explosion() -> void:
	if !mute: $Explosion.play()

func play_grab_object() -> void:
	if !mute: $GrabObject.play()

func play_drop_object() -> void:
	if !mute: $DropObject.play()
	
func play_swap_floor() -> void:
	if !mute: $SwapFloor.play()

func play_inavlid_action() -> void:
	if !mute: $InvalidAction.play()

func play_dialogue_sound():
	if !mute: $DialogueSound.play()
	
func play_water_splash():
	if !mute: $WaterSplash.play()

############################################### SONIDOS DE OBJETOS ################################
func play_bullet_shot():
	if !mute: $BulletShoot.play()
	
func play_box_explode():
	if !mute: $BoxExplode.play()

func play_button_press():
	if !mute: $ButtonPress.play()

############################################### SONIDOS DEL MAPA ################################
func play_map_zone_notification():
	if !mute: $MapZoneNotification.play()

################################################### OTROS #######################################
func play_peek():
	if !mute: $Peek.play()
