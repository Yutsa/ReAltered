extends Node
class_name TextureLoader

var http_request = HTTPRequest.new()

signal texture_loaded(texture: Texture2D)

func _ready():
	add_child(http_request)
	http_request.request_completed.connect(self.handle_response)	

func load_texture(url: String):
	var error = http_request.request(url)
	if error != OK:
		push_error("An error occurred in the HTTP request.")
	
func handle_response(result, response_code, headers, body):
	if result != HTTPRequest.RESULT_SUCCESS:
		push_error("Image couldn't be downloaded.")

	var image = Image.new()
	var error = image.load_jpg_from_buffer(body)
	if error != OK:
		push_error("Couldn't load the image.")

	texture_loaded.emit(ImageTexture.create_from_image(image))
