extends Control

@export var spread_curve: Curve
@export var height_curve: Curve
@export var rotation_curve: Curve

const HAND_WIDTH = 20
const HAND_HEIGHT = 20
const ROTATION_CONSTANT = -0.3

const CARD = preload("res://cards/card.tscn")

func _ready():
	for i in 6:
		var card = CARD.instantiate()
		card.card_id = "card" + str((i % 3) + 1) 
		card.tree_exited.connect(spread_cards)
		add_child(card)
	spread_cards()


func spread_cards():
	var number_of_cards = get_children().size()
	print(number_of_cards)
	for card in get_children():
		card.position = Vector2(-1, 0)
		var hand_ratio = compute_hand_ratio(card)
		card.position.x += spread_curve.sample(hand_ratio) * HAND_WIDTH * number_of_cards
		card.position += height_curve.sample(hand_ratio) * Vector2.UP * HAND_HEIGHT
		card.rotation = rotation_curve.sample(hand_ratio) * ROTATION_CONSTANT

func compute_hand_ratio(card):
	if get_child_count() > 1:
		return float(card.get_index()) / float(get_child_count() - 1)
	return 0.5
