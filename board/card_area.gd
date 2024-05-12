extends Area2D

var card_on_board_scene = preload("res://board/card_on_board.tscn")
var card_over_zone

func _on_area_entered(area):
	if area is Card:
		card_over_zone = area

func add_card_to_area(card_id):
	var instance = card_on_board_scene.instantiate()
	instance.card_id = card_id
	print(instance.card_id)
	$HBoxContainer.add_child(instance)

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT \
	 and (event.is_released() or not event.pressed) and card_over_zone != null:
		add_card_to_area(card_over_zone.card_id)
		card_over_zone.queue_free()
		card_over_zone = null
