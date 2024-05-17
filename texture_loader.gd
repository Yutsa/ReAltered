extends Node

var http_request = HTTPRequest.new()

func _ready():
	add_child(http_request)
	http_request.request_completed.connect(self.handle_response)	

func load_texture(url: String, texturable):
	var error = http_request.request("https://altered-prod-eu.s3.amazonaws.com/Art/CORE/CARDS/ALT_CORE_B_OR_09/JPG/fr_FR/81ada56478653da314bf88d192cf3719.jpg")
	if error != OK:
		push_error("An error occurred in the HTTP request.")
	
func handle_response(result, response_code, headers, body):
	if result != HTTPRequest.RESULT_SUCCESS:
		push_error("Image couldn't be downloaded. Try a different image.")

	var image = Image.new()
	var error = image.load_jpg_from_buffer(body)
	if error != OK:
		push_error("Couldn't load the image.")

	return ImageTexture.create_from_image(image)
