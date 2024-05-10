extends Node2D

var mouse_over = false
var is_dragging = false

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_unhandled_input(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_mouse_entered():
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	$Area2D/CardImage.scale = Vector2(0.5, 0.5)
	mouse_over = true


func _on_area_2d_mouse_exited():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	mouse_over = false
	$Area2D/CardImage.scale = Vector2(0.3, 0.3)

func _unhandled_input(event: InputEvent):
	if mouse_over and event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		is_dragging = true
	elif mouse_over and event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_released():
		is_dragging = false
	if is_dragging and event is InputEventMouseMotion:
		position += event.relative
