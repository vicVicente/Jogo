extends Control


func add_points(points:int):
	$Panel/ScoreFimLabel.text = "Score: " + str(points)


func _on_Button_pressed():
	get_tree().quit()
