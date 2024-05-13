extends Area2D

var card_on_board_scene = preload("res://board/card_on_board.tscn")
	
func add_card(card):
	if card.is_in_group("card"):
		var instance = card_on_board_scene.instantiate()
		instance.card_id = card.card_id
		$HBoxContainer.add_child(instance)
		card.queue_free()
