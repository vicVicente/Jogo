extends KinematicBody2D


func _ready():
	pass # Replace with function body.


var velocidade = 100
var direcao    = 1  # 1 para direita, -1 para esquerda 
var forca_gravidade = 30
var mov = Vector2.ZERO

func _physics_process(delta):
	mov.y += forca_gravidade * delta

	# Verifica se há chão à frente
	if direcao == -1 and not $RayCast2Esq.is_colliding():
		# Não há chão à esquerda, inverte direção
		direcao = 1
		$Sprite.flip_h = true

	elif direcao == 1 and not $RayCast2Dr.is_colliding():
		# Não há chão à direita, inverte direção
		direcao = -1
		$Sprite.flip_h = false

	mov.x = velocidade * direcao


	mov = move_and_slide(mov, Vector2.UP)

func causar_dano(body):
	if (body.name=="Personagem"):
		body.get_node("AnimationPlayer2").play("dano")
		ScriptGlobal.qtd_vidas -= 1

	
func eliminar_inimigo(anim_name):
	if (anim_name=="morrendo"):
		get_parent().queue_free()
		
		
