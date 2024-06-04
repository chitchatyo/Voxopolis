extends TextureButton
var toggle = false
var animdone = false
var did = false
@onready var anim = $AnimationPlayer
@onready var menuanim = $"../Panel/AnimationPlayer"
@onready var menu = $"../Panel"
signal state(toggled:bool)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if animdone == false:
		if toggle == true and animdone == false:
			anim.play("open")
			menuanim.play("open")
			animdone = true
		if toggle == false and animdone == false:
			anim.play("close")
			menuanim.play("close")
			animdone = true
	pass


func _on_button_down():
	if did == false:
		if toggle == false and did == false:
			animdone = false
			did = true
			menu.visible = true
			toggle = true
			emit_signal("state",toggle)
		if toggle == true and did == false:
			animdone = false
			did = true
			toggle = false
			emit_signal("state",toggle)
	pass # Replace with function body.


func _on_button_up():
	did = false
	pass # Replace with function body.


func _on_animation_player_animation_finished(anim_name):
	pass # Replace with function body.
