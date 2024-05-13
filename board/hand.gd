extends Control

var center = get_viewport_rect().size / 2.0
# Called when the node enters the scene tree for the first time.
func _ready():
	var children = get_children()
	for index in children.size():
		var card = children[index]
		card.position.x = center.x + (index * 100)
		card.position.y = center.y + (index * 3)
		card.rotation_degrees += index * 3


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
