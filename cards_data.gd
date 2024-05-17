extends Node

var json = preload("res://data/cards/cards.json")

func get_card_data(card_id):
	return json.data[card_id]
