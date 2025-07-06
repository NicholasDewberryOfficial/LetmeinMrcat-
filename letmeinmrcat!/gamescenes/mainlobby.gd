extends Node2D


func _on_speaktocat_pressed() -> void:
	get_tree().change_scene_to_file("res://art/cattalk/cattalk.tscn")
	pass # Replace with function body.


func _on_explore_pressed() -> void:
	pass # Replace with function body.


func _on_puzzles_pressed() -> void:
	get_tree().change_scene_to_file("res://gamescenes/puzzles/puzzlesscene.tscn")
	pass # Replace with function body.
