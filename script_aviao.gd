extends Area2D

onready var personagem = get_node("Node2D/player/Personagem")
onready var animation_player = $AnimationPlayer

func passar_de_fase(body):
	if body.name == "Personagem":
		start_takeoff()

func start_takeoff():
	animation_player.play("takeoff")
	yield(animation_player, "animation_finished")
	change_scene()

func change_scene():
	get_tree().change_scene("res://scene/Game.tscn")
