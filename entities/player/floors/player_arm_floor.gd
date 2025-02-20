extends Floor

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var grab_area = $GrabArea

var grabbed_item : CharacterBody2D

func _ready():
	animated_sprite_2d.play("idle")
	player.change_direction.connect(change_direction)
	player.action.connect(grab_object)
	player.stop_action.connect(drop_object)

func _physics_process(delta):
	
	# SI NO TIENE NADA, VUELVE A LA ANIMACIÓN NORMAL
	if !grabbed_item:
		animated_sprite_2d.play("idle")
	print(grabbed_item)

func change_direction():
	if scale.x != player.dir: 
		position.x += 15 * player.dir
		scale.x = player.dir

#	AGARRA ALGO SI NO TIENE NADA Y SI HAY ALGO EN EL AREA
func grab_object():
	if !grabbed_item:
		if len(grab_area.get_overlapping_bodies()) > 0:
			var item = grab_area.get_overlapping_bodies()[0]
			
	#		ALMACENA EL ITEM SI ES AGARRABLE Y LO MARCA COMO AGARRADO
			if !item.grabbed && item.is_in_group("grabeable"):
				animated_sprite_2d.play("grab")
				item.grabbed_by = self
				item.grabbed = true
				grabbed_item = item

#	SI TIENE UN ITEM AGARRADO LO SUELTA SIEMPRE Y CUANDO NO CHOQUE CON EL PISO U OTROS OBJETOS AGARABLES. LO MARCA COMO NO AGARRADO
func drop_object():
	if is_instance_valid(grabbed_item):
		if len(grabbed_item.floor_detect_area.get_overlapping_bodies()) == 0:
			animated_sprite_2d.play("idle")
			grabbed_item.grabbed_by = null
			grabbed_item.grabbed = false
			grabbed_item = null
