extends SubViewport


# Called when the node enters the scene tree for the first time.
func _ready():
	$Panel.size = $Panel/Label.size + Vector2(3*3,15*2)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
