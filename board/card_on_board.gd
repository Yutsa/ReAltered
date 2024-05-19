extends TextureRect

@export var card_id = "ALT_CORE_B_AX_18_C"
var card_logic: CardLogic

# Called when the node enters the scene tree for the first time.
func _ready():
	card_logic = CardLogic.new()
	card_logic.card_id = card_id
	add_child(card_logic)
	var texture_loader = TextureLoader.new()
	texture_loader.card = card_logic
	add_child(texture_loader)
	texture_loader.texture_loaded.connect(func (texture: Texture2D): self.texture = texture)
	texture_loader.load_card_art()
	set_card_values()

func set_card_values():
	$OceanValueRect/OceanValue.text = str(card_logic.ocean_power)
	$MoutainValueRect/MountainValue.text = str(card_logic.mountain_power)
	$ForestValueRect/ForestValue.text = str(card_logic.forest_power)
