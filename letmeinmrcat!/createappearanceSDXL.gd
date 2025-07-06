extends Node2D

@export var bgcharacter = Texture
var prompt = "A maltese puppy"

var imgpayload := {
	"prompt": "A realistic portrait of a young woman in a forest",
	"steps": 6,
	"cfg_scale": 1.5,
	"sampler_name": "DPM++ SDE Karras", # Must match a valid sampler listed in your webui
	"width": 768,
	"height": 512,
	"negative_prompt": "explicit, nudity, deformed iris, deformed pupils, semi-realistic, cgi, 3d, render, sketch, cartoon, drawing, anime), text, cropped, out of frame, worst quality, low quality, jpeg artifacts, ugly, duplicate, morbid, mutilated, extra fingers, mutated hands, poorly drawn hands, poorly drawn face, mutation, deformed, blurry, dehydrated, bad anatomy, bad proportions, extra limbs, cloned face, disfigured, gross proportions, malformed limbs, missing arms, missing legs, extra arms, extra legs, fused fingers, too many fingers, long neck, UnrealisticDream"
}

var strimgpayload
var localimgurl := "http://127.0.0.1:7860/sdapi/v1/txt2img"
var imgheaders := PackedStringArray(["Content-Type: application/json"])

func _ready() -> void:
	$toastsprite.stop()
	pass
	
func performRequest():
		$toastsprite.play()
		$HTTPRequest.cancel_request()
		$HTTPRequest.request(localimgurl, imgheaders, HTTPClient.METHOD_POST, strimgpayload)
	

func _on_http_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	$toastsprite.stop()
	if response_code != 200:
		print("Failed with code:", response_code)
		return
	
	var json := JSON.new()
	var parse_result := json.parse(body.get_string_from_utf8())
	if parse_result != OK:
		print("JSON parse error")
		return
	
	var data = json.get_data()
	if typeof(data) == TYPE_DICTIONARY and data.has("images"):
		var b64 = data["images"][0]
		var image = Image.new()
		var err = image.load_png_from_buffer(Marshalls.base64_to_raw(b64))
		
		if err == OK:
			var texture = ImageTexture.create_from_image(image)
			var sprite = Sprite2D.new()
			$imagefromuser.texture = texture
			add_child(sprite)
		else:
			print("Error loading image:", err)

func switch_model(model_name: String) -> void:
	var payload := {"sd_model_checkpoint": model_name}
	var str_payload := JSON.stringify(payload)
	var headers := PackedStringArray(["Content-Type: application/json"])
	var url := "http://127.0.0.1:7860/sdapi/v1/options"
	$HTTPRequest.request(url, headers, HTTPClient.METHOD_POST, str_payload)



func _on_generatebutton_pressed() -> void:
	switch_model("realisticVisionV60B1_v51HyperVAE.safetensors [f47e942ad4]")
	imgpayload.prompt = $userinput.text
	strimgpayload = JSON.stringify(imgpayload)
	performRequest()
	pass # Replace with function body.


func _on_move_on_pressed() -> void:
	gv.pcsprite = $imagefromuser.texture
	pass # Replace with function body.


func _on_anonymouspicture_pressed() -> void:
	$HTTPRequest.cancel_request()
	$imagefromuser.texture = bgcharacter
	pass # Replace with function body.
