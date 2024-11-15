extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
var velocidade = 100
var direcao    = 1  # 1 para direita, -1 para esquerda 
var forca_gravidade = 30
var mov = Vector2.ZERO

func _process(delta):
	mov.y += forca_gravidade	
	if (not $RayCast2Esq.is_colliding()):
		direcao = 1
		$Sprite.flip_h = true
		
	if (not $RayCast2Dr.is_colliding()):
		direcao = -1
		$Sprite.flip_h = false
		
	if (direcao==1):
		mov.x = velocidade	
	elif (direcao==-1):
		mov.x = -velocidade	
		
	mov = move_and_slide(mov)
	

func causar_dano(body):
	if (body.name=="Personagem"):
		body.get_node("AnimationPlayer2").play("dano")
		ScriptGlobal.qtd_vidas -= 1

	
func eliminar_inimigo(anim_name):
	if (anim_name=="morrendo"):
		get_parent().queue_free()
