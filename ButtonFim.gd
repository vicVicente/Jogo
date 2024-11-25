extends Button

# Função chamada quando o botão é pressionado
func _on_pressed():
	get_tree().quit()

# Configuração inicial
func _ready():
	# Conecta o sinal 'pressed' ao método '_on_pressed'
	connect("pressed", self, "_on_pressed")
