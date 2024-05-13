extends Node2D
class_name Card
	
@export var card_id = "card1"
var mouse_over = false
var is_dragging = false
var hovered_board_area = null
var position_before_drag : Vector2

func _ready():
	$CardImage.texture = load("res://img/cards/" + card_id + ".jpg")

func _on_area_2d_mouse_entered():
	if is_dragging:
		return
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	$CardImage.scale = Vector2(0.4, 0.4)
	$CardImage.z_index = 1
	mouse_over = true

func _on_area_2d_mouse_exited():
	if is_dragging:
		return
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	mouse_over = false
	$CardImage.z_index = 0
	$CardImage.scale = Vector2(0.3, 0.3)

func _on_control_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		is_dragging = true
		position_before_drag = position
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		$CardImage.scale = Vector2(0.3, 0.3)
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and (event.is_released() or not event.pressed):
		is_dragging = false
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		if hovered_board_area == null:
			position = position_before_drag
		else:
			hovered_board_area.add_card(self)
	if is_dragging and event is InputEventMouseMotion:
		position += event.relative


func _on_area_entered(area):
	if (area.is_in_group("board_area")):
		hovered_board_area = area


func _on_area_exited(area):
	if (area.is_in_group("board_area")):
		hovered_board_area = null
