extends Control


func _on_start_pressed():
	#get_tree().change_scene_to_file("res://Scene/world.tscn")
	Transition.change_scene("res://Scene/world.tscn")


func _on_exit_pressed():
	get_tree().quit()
