extends Node

#NOTE: NONE OF THIS WORKS!
#I use ollama instead

const AIHORDE_URL      := "https://aihorde.net/api/v2/generate/text/async"
const API_KEY          := "#0000000000"       # use "0000000000" for anon
const CLIENT_AGENT     := "Game" # identify yourself

var prompt := """You are QEEMO, a Sphinx … START
"""
var currentconversation := ""
var responsesleft := 0
var job_id := ""               # ← holds async request id between calls

func _ready() -> void:
	responsesleft = 4

func _process(_delta: float) -> void:
	$catresponse.text = currentconversation
	$userresponsesleft.text = "Responses left: " + str(responsesleft)
	$sendresponse.disabled = responsesleft == 0

func _on_sendresponse_pressed() -> void:
	responsesleft -= 1
	if $usertextresponse.text == "G9b*":
		get_tree().change_scene_to_file("res://gamescenes/youwin.tscn")

	# add user line to running prompt/conversation
	prompt += "\nUser: %s\n" % $usertextresponse.text
	currentconversation += "\n " + $usertextresponse.text
	$usertextresponse.text = ""
	$toastsprite.play()

	var payload := {
		"prompt": prompt,
		"models": ["koboldcpp/zephyr-7b"],   # pick any text model
		"params": {                          # generation settings
			"max_tokens": 160,
			"temperature": 0.75,
			"top_p": 0.9
		}
	}
	var headers := PackedStringArray([
		"Content-Type: application/json",
		"apikey: %s" % API_KEY,
		"Client-Agent: %s" % CLIENT_AGENT
	])

	# 1 — submit async generation request
	$HTTPRequest.request(
		"%s/async" % AIHORDE_URL,
		headers,
		HTTPClient.METHOD_POST,
		JSON.stringify(payload)
	)


func _poll_status() -> void:
	var headers := PackedStringArray([
		"apikey: %s" % API_KEY,
		"Client-Agent: %s" % CLIENT_AGENT
	])
	$HTTPRequest.request(
		"%s/status/%s" % [AIHORDE_URL, job_id],
		headers,
		HTTPClient.METHOD_GET
	)
	# if not done, schedule another poll in 2 s
	await get_tree().create_timer(2.0).timeout
	# prevent double-poll once done
	if job_id != "":
		_poll_status()

func _on_http_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var json_text := body.get_string_from_utf8()

	# 1. Parse safely
	var json := JSON.new()
	var err   := json.parse(json_text)
	if err != OK:
		push_error("JSON parse error %s at line %d ‒\n%s"
				   % [json.get_error_message(), json.get_error_line(), json_text])
		return

	var data : Dictionary = json.data          # <-- guaranteed Dictionary here

	# 2. Handle the two possible responses -----------------------------------
	if data.has("id"):                         # first call → job UUID
		job_id = data["id"]
		_poll_status()
	elif data.has("generations"):              # status call → final text
		var text = data["generations"][0]["text"]
		prompt += "\nQEEMO: %s\n" % text
		currentconversation += "\n [color=LIGHTBLUE]%s[/color]" % text
		$toastsprite.stop()


func _on_gonext_pressed() -> void:
	get_tree().change_scene_to_file("res://gamescenes/mainlobby.tscn")
	pass # Replace with function body.
