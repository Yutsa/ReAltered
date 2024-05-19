extends Node
class_name TextureLoader

const CARD_PIC_DIRECTORY = "user://cards/"
var card: CardLogic
var lang = 'fr'

var http_request = HTTPRequest.new()

signal texture_loaded(texture: Texture2D)

func _ready():
	add_child(http_request)
	http_request.request_completed.connect(self.handle_response)
	DirAccess.make_dir_recursive_absolute(CARD_PIC_DIRECTORY + lang)

func load_texture(url: String):
	var error = http_request.request(url)
	if error != OK:
		push_error("An error occurred in the HTTP request.")
		
func load_card_texture():
	if local_image_exists():
		load_card_image_from_file()
	else:
		load_card_image_from_network()
		
func local_image_exists():
	FileAccess.file_exists(get_card_image_path())
	
func get_card_image_path():
	return CARD_PIC_DIRECTORY + str(lang) + '/' + str(card.card_id) + ".jpg"
	
func load_card_image_from_file():
	var image = Image.load_from_file(get_card_image_path())
	texture_loaded.emit(ImageTexture.create_from_image(image))

func load_card_image_from_network():
	var url = card.get_card_image_url(lang)
	var error = http_request.request(url)
	if error != OK:
		push_error("An error occurred in the HTTP request.")
	
func handle_response(result, response_code, headers, body):
	if result != HTTPRequest.RESULT_SUCCESS:
		push_error("Image couldn't be downloaded.")

	var image = Image.new()
	var error = image.load_jpg_from_buffer(body)
	image.save_jpg(get_card_image_path())
	if error != OK:
		push_error("Couldn't load the image.")

	texture_loaded.emit(ImageTexture.create_from_image(image))
