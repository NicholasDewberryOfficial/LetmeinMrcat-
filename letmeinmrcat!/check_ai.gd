extends Node2D

var imgheaders := PackedStringArray(["Content-Type: application/json"])

func _ready():
	pass


func _on_check_img_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	if(response_code != 200):
		$regimg/imgconstatus.text = "Image algo not connected"
		$regimg/imgcolor.modulate = Color.RED
	else:
		$regimg/imgconstatus.text = "Image algo working!"
		$regimg/imgcolor.modulate = Color.GREEN

	pass # Replace with function body.
	
	


func _on_checkimgconnectino_pressed() -> void:
	$regimg/checkIMG.cancel_request()
	$regimg/checkIMG.request("http://127.0.0.1:7860", imgheaders, HTTPClient.METHOD_GET, "hi")
	#$checkIMG.request("http://127.0.0.1:7860", imgheaders, HTTPRequest.GET, null)
	pass # Replace with function body.


func _on_check_txt_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	if(response_code != 200):
		$regtxt/txtconstatus.text = "Text algo not connected"
		$regtxt/txtcolor.modulate = Color.RED
	else:
		$regtxt/txtconstatus.text = "Text algo working!"
		$regtxt/txtcolor.modulate = Color.GREEN


func _on_chectxtconnection_pressed() -> void:
	$regtxt/checkTXT.cancel_request()
	var prompt := "Why is the sky blue? Answer in under 30 words."
	# Build the JSON payload expected by /api/generate
	var payload := {
		"model": "gemma3:4b",   # any model you have pulled
		"prompt": prompt,
		"stream": false          # one-shot response
	}
	var body := JSON.stringify(payload)

	# Correct header – tell the server we’re sending JSON
	var headers := PackedStringArray([
		"Content-Type: application/json"
	])
	$regtxt/checkTXT.request("http://localhost:11434/api/generate",
		headers,
		HTTPClient.METHOD_POST,
		body)


func _on_backtomainmenu_pressed() -> void:
	get_tree().change_scene_to_file("res://mainmenu.tscn")
	pass # Replace with function body.
