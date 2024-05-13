extends Node2D
class_name Card
	
@export var card_id = "card1"
var mouse_over = false
var is_dragging = false
var hovered_board_area = null
var position_before_drag : Vector2
var rotation_before_drag = null
var show_zoom = false

func _ready():
	$CardImage.texture = load("res://img/cards/" + card_id + ".jpg")
	
func zoom():
	if not show_zoom:
		$CardImage.scale = Vector2(0.25, 0.25)
		$CardImage.z_index = 1
		$CardImage.position.y -= 100
		show_zoom = true
	
func unzoom():
	if show_zoom:
		$CardImage.scale = Vector2(0.15, 0.15)
		$CardImage.z_index = 0
		$CardImage.position.y += 100
		show_zoom = false
		
func drag_card():
	is_dragging = true
	position_before_drag = position
	rotation_before_drag = rotation_degrees
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	unzoom()
	rotation_degrees = 0
	$CardImage.z_index = 2

func drop_card():
	is_dragging = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if hovered_board_area == null:
		position = position_before_drag
		rotation_degrees = rotation_before_drag
		$CardImage.z_index = 0
	else:
		hovered_board_area.add_card(self)

func _on_area_2d_mouse_entered():
	if is_dragging or Input.is_mouse_button_pressed(1):
		return
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	zoom()
	mouse_over = true

func _on_area_2d_mouse_exited():
	if is_dragging:
		return
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	mouse_over = false
	unzoom()

func _on_control_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		drag_card()
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and (event.is_released() or not event.pressed):
		drop_card()
	if is_dragging and event is InputEventMouseMotion:
		position += event.relative


func _on_area_entered(area):
	if (area.is_in_group("board_area")):
		hovered_board_area = area


func _on_area_exited(area):
	if (area.is_in_group("board_area")):
		hovered_board_area = null
