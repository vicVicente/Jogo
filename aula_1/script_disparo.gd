extends Area2D

var velociadade = 10
var direcao = 1 #1 = direita; -1 = esquerda

func _ready():
	get_tree().root.print_tree()
	
	pass # Replace with function body.
	
func _process(delta):
	if(direcao==1):
		$Sprite.flip_h = false
	elif(direcao==-1):
		$Sprite.flip_h = true
	global_position.x += (velociadade * direcao)


func destruir_inimigo(body):
	if(body.name=="Inimigo"):
		body.get_node("AnimationPlayer").play("morrendo")
		body.velocidade = 0
		get_parent().queue_free()
