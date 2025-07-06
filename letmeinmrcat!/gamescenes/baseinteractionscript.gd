extends Node

func _ready() -> void:
	# The prompt you want to ask the model
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

	# Send the POST request
	var err = $HTTPRequest.request(
		"http://localhost:11434/api/generate",
		headers,
		HTTPClient.METHOD_POST,
		body                         # <- JSON goes here
	)
	if err != OK:
		push_error("Request failed: %s" % err)

func _on_http_request_request_completed(result:int,
		response_code:int,
		headers:PackedStringArray,
		body:PackedByteArray) -> void:
	var text := body.get_string_from_utf8()

	var j = JSON.parse_string(text)
	if j is Dictionary and j.has("response"):
		print(j["response"])
