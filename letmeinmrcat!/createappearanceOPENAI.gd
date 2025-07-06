extends Node2D

var option_payload = {
	#"sd_model_checkpoint": "Anything-V3.0-pruned",
	"sd_model_checkpoint": "V1-5-pruned-emaonly",
	"CLIP_stop_at_last_layers": 2
}
var stringypayload = JSON.stringify(option_payload)
var optionsapi = "http://127.0.0.1:7860/sdapi/v1/options"

var imgpayload = {
	"prompt": "maltese puppy",
	"steps": 5,
}



var strimgpayload = JSON.stringify(imgpayload)
var localimgurl = "http://127.0.0.1:7860s/dapi/v1/txt2img"
var imgheaders = PackedStringArray([
		"Content-Type: application/json"
	])
func _ready() -> void:
	#$HTTPRequest.request(optionsapi, ["Content-Type: application/json"], HTTPClient.METHOD_POST, stringypayload)
	
	$HTTPRequest.request(localimgurl, imgheaders, HTTPClient.METHOD_POST, strimgpayload)
	pass

func _on_http_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	print(response_code)
	print(result)
	var text := body.get_string_from_utf8()
	#print("HTTP ", response_code)
	#print(text)

	var j = JSON.parse_string(text)
	if j is Dictionary and j.has("response"):
		#print("Model says:", j["response"])
		print(j["response"])
	pass # Replace with function body.


func _on_generatebutton_pressed() -> void:
	pass # Replace with function body.
