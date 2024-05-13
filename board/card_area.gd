extends Area2D

var card_on_board_scene = preload("res://board/card_on_board.tscn")
var card_to_drop = null
	
func add_card():
	if card_to_drop.is_in_group("card"):
		var instance = card_on_board_scene.instantiate()
		instance.card_id = card_to_drop.card_id
		$HBoxContainer.add_child(instance)
		card_to_drop.queue_free()


func _on_area_entered(area):
	if area.is_in_group("card"):
		print("Add card")
		card_to_drop = area

func _on_area_exited(area):
	print("Remove card")
	card_to_drop = null
