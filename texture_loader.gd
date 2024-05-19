extends Node
class_name TextureLoader

const CARD_PIC_DIRECTORY = "user://cards/"
const CARD_ART_PIC_DIRECTORY = "user://cards-art/"
var card: CardLogic
var lang = 'fr'

var http_request = HTTPRequest.new()

signal texture_loaded(texture: Texture2D)

func _ready():
	add_child(http_request)
	DirAccess.make_dir_recursive_absolute(CARD_PIC_DIRECTORY + lang)
	DirAccess.make_dir_recursive_absolute(CARD_ART_PIC_DIRECTORY + lang)

func load_card_texture():
	var url = card.get_card_image_url(lang)
	load_texture(CARD_PIC_DIRECTORY, url)

func load_card_art():
	var url = card.get_card_art()
	load_texture(CARD_ART_PIC_DIRECTORY, url)

func load_texture(directory: String, url: String):
	if local_image_exists(directory):
		load_card_image_from_file(directory)
	else:
		load_card_image_from_network(directory, url)
		
func local_image_exists(directory: String):
	var dir = DirAccess.open(directory + lang)
	return dir.file_exists(card.card_id + '.jpg')
	
func get_card_image_path(directory: String):
	return directory + str(lang) + '/' + str(card.card_id) + ".jpg"
	
func load_card_image_from_file(directory: String):
	var image = Image.load_from_file(get_card_image_path(directory))
	if directory == CARD_ART_PIC_DIRECTORY:
		image.crop(700, 800)
	texture_loaded.emit(ImageTexture.create_from_image(image))

func load_card_image_from_network(directory: String, url: String):
	http_request.request_completed.connect(self.handle_response.bind(directory))
	var error = http_request.request(url)
	if error != OK:
		push_error("An error occurred in the HTTP request.")
	
func handle_response(result, response_code, headers, body, directory):
	if result != HTTPRequest.RESULT_SUCCESS:
		push_error("Image couldn't be downloaded.")

	var image = Image.new()
	var error = image.load_jpg_from_buffer(body)
	image.save_jpg(get_card_image_path(directory))
	if error != OK:
		push_error("Couldn't load the image.")

	texture_loaded.emit(ImageTexture.create_from_image(image))
