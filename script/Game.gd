extends Node2D


onready var ui = $HUD/UI
onready var player = $Player
onready var scroll_background = $ParallaxBackground


var player_points:int = 0
var lifes = 3
var parallax_speed:int = 200
var game_over_scene = preload("res://scene/GameOverUI.tscn")
var fim_game = preload("res://Fim.tscn")


func _ready():
	lifes = 3
	player_points = 0
	
	
func _process(delta):
	scroll_background.offset.x -= parallax_speed * delta
	if scroll_background.offset.x <= - get_viewport().size.x:
		scroll_background.offset.x = 0


func _on_Spawn_Container_spawn_enemy(enemy):
	# Conecta o sinal "give_points" do inimigo à função "on_give_points"
	enemy.connect("give_points", self, "_on_give_points")
	$Spawn_Container.add_child(enemy)
	
	
func _on_give_points(points):
	player_points += points
	ui.add_points(player_points)
	$ExplodeSound.play()
	
	if player_points >= 100:
		_on_end_game()


func _on_Player_took_damage():
	lifes -= 1
	ui.set_lifes(lifes)
	if lifes == 0:
		player.die()
		var timer = Timer.new()
		timer.wait_time = 1.5
		timer.one_shot = true
		timer.connect("timeout", self, "_on_game_over")
		add_child(timer)  # Adiciona o Timer à árvore de cenas
		timer.start()

func _on_end_game():
	var fim_game_instance = fim_game.instance()
	fim_game_instance.add_points(player_points)
	ui.add_child(fim_game_instance)
	
func _on_game_over():
	# Esta função será chamada após 1.5 segundos
	var game_over_instance = game_over_scene.instance()
	game_over_instance.add_points(player_points)
	ui.add_child(game_over_instance)
	
