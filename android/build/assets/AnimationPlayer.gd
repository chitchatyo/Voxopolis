extends AnimationPlayer
@onready var MenuAnim = $"."
@onready var Menu = $".."
var iMenuPressed = 0
var pressed = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if iMenuPressed == 0:
		if pressed == true:
			MenuAnim.stop()
			MenuAnim.play('close')
			pressed = false
			print("ANIMATION CLOSE")
	else:
		if iMenuPressed == 1:
			if pressed == true:
				MenuAnim.stop()
				MenuAnim.play("open")
				pressed = false
				print("ANIMATION OPEN")
	pass

func _on_button_pressed():
	print("PRESSED")
	if iMenuPressed == 0:
		pressed = true
		iMenuPressed = 1
		print("OFF")
	else:
		if iMenuPressed == 1:
			pressed = true
			iMenuPressed = 0
			print("ON")
	pass # Replace with function body.
