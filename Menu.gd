extends Control

func _ready():
	$MarginContainer/HBoxContainer/VBoxContainer/start_btn.connect("pressed", self, "_on_start_button_pressed")
	$MarginContainer/HBoxContainer/VBoxContainer/sair_btn.connect("pressed", self, "_on_exit_button_pressed")

func _on_start_button_pressed():
	var new_scene = load("res://cena_fase.tscn") 
	get_tree().change_scene_to(new_scene) 

func _on_exit_button_pressed():
	get_tree().quit()
