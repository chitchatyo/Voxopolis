extends TextureButton
enum Visibility_mode {
	ALWAYS, ## Always visible
	TOUCHSCREEN_ONLY ## Visible on touch screens only
}

## If the joystick is always visible, or is shown only if there is a touchscreen
@export var visibility_mode := Visibility_mode.ALWAYS

# Called when the node enters the scene tree for the first time.
func _ready():
	if visibility_mode == Visibility_mode.TOUCHSCREEN_ONLY and not DisplayServer.is_touchscreen_available():
		hide()
	elif visibility_mode == Visibility_mode.ALWAYS:
		show()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_up():
	if DisplayServer.is_touchscreen_available():
		Input.action_release("jump")
	pass # Replace with function body.


func _on_button_down():
	if DisplayServer.is_touchscreen_available():
		Input.action_press("jump")
	pass # Replace with function body.
