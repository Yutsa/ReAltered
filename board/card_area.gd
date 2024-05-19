extends Area2D

var card_on_board_scene = preload("res://board/card_on_board.tscn")
var card_to_drop = null
@export var type : CardAreaLogic.Card_Area
	
func add_card(card: Card):
	var instance = card_on_board_scene.instantiate()
	instance.init(card.card_logic)
	$HBoxContainer.add_child(instance)
	card.queue_free()
