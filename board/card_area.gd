extends Area2D

var mouse_over = false

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_unhandled_input(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _unhandled_input(event: InputEvent):
	if mouse_over and event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		pass

func _on_mouse_entered():
	mouse_over = true


func _on_mouse_exited():
	mouse_over = false


func _on_area_entered(area):
	print("Something entered") # Replace with function body.
