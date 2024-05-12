extends TextureRect

@export var card_id = "card1"

# Called when the node enters the scene tree for the first time.
func _ready():
	texture = load("res://img/cards/" + card_id + ".jpg")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
