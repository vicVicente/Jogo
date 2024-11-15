extends KinematicBody2D

var velocidade = 300
var forca_pulo = 600
var gravidade = 30
var mov = Vector2.ZERO
var pulando = false
var atirando = false
var direcao = 1 


# warning-ignore:unused_argument
func _process(delta):
	mov.x = 0 
	mov.y += gravidade
	if (not atirando):
		if(Input.is_action_pressed("ui_left")): # Ir para esquerda.
			mov.x = -velocidade
			$Sprite.flip_h = true #Virando a imagem para a esquerda.
			direcao = -1
		elif (Input.is_action_pressed("ui_right")): # Ir para direita.
			mov.x = velocidade
			$Sprite.flip_h = false #Virando a imagem para a direita.
			direcao = 1
		
	if(Input.is_action_just_pressed("ui_up") and is_on_floor()): # Pular and "tem que estar no chão".
		mov.y = -forca_pulo
	
	if(is_on_floor()): # Ele está no chão?
		pulando = false
		if(not atirando): #não está atirando
			if(mov.x == 0): # Ele está parado?
				$AnimationPlayer.play("parado")
				if(Input.is_action_pressed("ui_down") and is_on_floor()):
					$AnimationPlayer.play("abaixar")
			else:
				$AnimationPlayer.play("correndo")
				
				#if(Input.is_action_just_pressed("disparo")): # Para atirar correndo.
					#$AnimationPlayer.play("corre_atira")
			
			if(Input.is_action_just_pressed("disparo")):
				$AnimationPlayer.play("atira")
				atirando = true
				
		if($AnimationPlayer.current_animation == ""): # Parou de atirar
			atirando = false
		
	elif(not pulando):
		$AnimationPlayer.play("pulo")
		pulando = true
		atirando = false
		if(Input.is_action_just_pressed("disparo")):# Para atirar pulando.
			$AnimationPlayer.play("pula_atira")
			atirando = true
		
	mov = move_and_slide(mov, Vector2(0,-1))


func disparar(anim_name):
	if(anim_name == "atira"):
		var cena_disparo = preload("res://cena_disparo.tscn")
		var obj_disparo = cena_disparo.instance()
		
		get_tree().root.add_child(obj_disparo)
		
		if(direcao == 1):
			obj_disparo.global_position = $Position2DDir.global_position
		elif(direcao == -1):
			obj_disparo.global_position = $Position2DEsq.global_position
		
		obj_disparo.get_node("Area2D").direcao = direcao
