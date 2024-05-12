extends Node2D
class_name Card
	
@export var card_id = "card1"
var mouse_over = false
var is_dragging = false

func _ready():
	$CardImage.texture = load("res://img/cards/" + card_id + ".jpg")

func _on_area_2d_mouse_entered():
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	$CardImage.scale = Vector2(0.5, 0.5)
	mouse_over = true

func _on_area_2d_mouse_exited():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	mouse_over = false
	$CardImage.scale = Vector2(0.3, 0.3)

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		is_dragging = true
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and (event.is_released() or not event.pressed):
		is_dragging = false
		$CardImage.scale = Vector2(0.3, 0.3)
	if is_dragging and event is InputEventMouseMotion:
		if $CardImage.scale.x != 0.15:
			$CardImage.scale = Vector2(0.15, 0.15)
		position += event.relative
