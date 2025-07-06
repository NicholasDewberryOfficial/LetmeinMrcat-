extends Node2D


func _on_checkaiint_pressed() -> void:
	get_tree().change_scene_to_file("res://checkAI.tscn")
	pass # Replace with function body.


func _on_startgame_pressed() -> void:
	get_tree().change_scene_to_file("res://gamestart.tscn")
	pass # Replace with function body.
