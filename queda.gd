extends Area2D

onready var timer = $Timer

func _on_Area2D_body_entered(body):
	print("Se Fodeu!")
	Engine.time_scale = 0.5
	
	# Verifica se o corpo tem um nó chamado "CollisionShape2D" antes de tentar acessá-lo
	if body.has_node("CollisionShape2D"):
		body.get_node("CollisionShape2D").queue_free()
	
	timer.start()

func _on_Timer_timeout():
	if (Input.is_action_pressed("ui_accept")):
		ScriptGlobal.reset()
		get_tree().change_scene("res://cena_fase.tscn")
