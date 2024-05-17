extends Node
class_name CardLogic

var card_id : String
var card_data = null
var ocean_power = 0
var mountain_power = 0
var forest_power = 0
var main_cost = 0
var reserve_cost = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	card_data = CardsData.get_card_data(card_id)
	ocean_power = card_data.elements.OCEAN_POWER
	mountain_power = card_data.elements.MOUNTAIN_POWER
	forest_power = card_data.elements.FOREST_POWER
	main_cost = card_data.elements.MAIN_COST
	reserve_cost = card_data.elements.RECALL_COST

func get_card_image_url(lang='fr'):
	return card_data.imagePath[lang]
	
func get_card_art():
	for art_url in card_data.assets.WEB:
		if is_common() and art_url.ends_with("C_WEB.jpg"):
			return art_url
		if is_in_faction_rare() and art_url.ends_with("R_WEB.jpg"):
			return art_url
		if is_out_of_faction_rare() and art_url.ends_with("U_WEB.jpg"):
			return art_url
	
func is_common():
	return card_id.ends_with("_C")
	
func is_in_faction_rare():
	return card_id.ends_with("_R1")
	
func is_out_of_faction_rare():
	return card_id.ends_with("_R2")
