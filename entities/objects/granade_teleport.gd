extends Area2D

@onready var animated_sprite_2d = $AnimatedSprite2D

@export var teleport_id:int
var portals:Array[Node]
var my_portal:Node2D

func _ready():
    portals = get_tree().get_nodes_in_group("PortalG")
    animated_sprite_2d.play("idle")
    link_portal()


func link_portal():
    for portal in portals:
        if teleport_id == portal.portal_id: my_portal = portal


func _on_body_entered(body:Node2D):
    if body is Granade:
        animated_sprite_2d.play("teleporting")
        body.position = my_portal.position

func _on_animated_sprite_2d_animation_finished():
    AudioManager.play_map_zone_notification()
    animated_sprite_2d.play("idle")