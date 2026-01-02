extends Area2D

var current_portal_a : Node = null
var current_portal_z : Node = null

# CONSTANTES
const PORTAL_A = "A"
const PORTAL_Z = "Z"

# VARIABLES
var spawn_pos:Vector2
var portal_type:String
var can_teleport := true

func _ready():
    AudioManager.play_map_zone_notification()
    position = spawn_pos
    $AnimatedSprite2D.play(portal_type)

    # BORRAR PORTALES REPETIDOS
    match portal_type:
        PORTAL_A:
            if get_tree().get_first_node_in_group("PortalA"):
                get_tree().get_first_node_in_group("PortalA").erase_portal()                
            add_to_group("PortalA")

        PORTAL_Z:
            if get_tree().get_first_node_in_group("PortalZ"):
                get_tree().get_first_node_in_group("PortalZ").erase_portal()
            add_to_group("PortalZ")


func _on_animated_sprite_2d_animation_finished():
    if portal_type == PORTAL_A: $AnimatedSprite2D.play("A_loop")
    elif portal_type == PORTAL_Z: $AnimatedSprite2D.play("Z_loop")


func erase_portal():
    queue_free()


# SE TELETRANSPORTA AL TOCAR UN PORTAL
func _on_body_entered(body:Node2D):
    if body is Player && both_portals_activated() && can_teleport:
        match portal_type:
            PORTAL_A: 
                body.position = get_tree().get_first_node_in_group("PortalZ").spawn_pos
                get_tree().call_group("PortalZ", "set_teleport_false")

            PORTAL_Z: 
                body.position = get_tree().get_first_node_in_group("PortalA").spawn_pos
                get_tree().call_group("PortalA", "set_teleport_false")


# REACTIVA EL PORTAL AL SALIR DEL ÁREA
func _on_body_exited(body:Node2D):
    if body is Player: can_teleport = true

func both_portals_activated():
    if get_tree().get_first_node_in_group("PortalZ") && get_tree().get_first_node_in_group("PortalA"): return true
    return false

func set_teleport_false():
    can_teleport = false