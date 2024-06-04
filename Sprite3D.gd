extends Sprite3D

@onready var Stamina = $CanvasLayer/Stamina
@onready var EditName = $CanvasLayer/NickEdit
@onready var Name = $CanvasLayer/main/Nick
@onready var infstaminab = $CanvasLayer/CheckButton
#CHAT
@onready var Chat = $CanvasLayer/Chat
@onready var ChatTEXT = $CanvasLayer/ChatTEXT
#SLIDERS
@onready var StaminaSlider = $CanvasLayer/Slider
@onready var TSS = $CanvasLayer/TSS
@onready var JPS = $CanvasLayer/JPS
@onready var SS = $CanvasLayer/SS
@onready var FOV = $CanvasLayer/FOV
@onready var HS = $CanvasLayer/HS
@export var Health : float = 100
#VALUES
@onready var TS = $CanvasLayer/TS
@onready var JP = $CanvasLayer/JP
@onready var S = $CanvasLayer/S
@onready var FOVTEXT = $CanvasLayer/FOVTEXT
@onready var HealthText = $CanvasLayer/Health
#Define the Popup
@onready var popup = $CanvasLayer/popup
@onready var accept = $CanvasLayer/popup/okay
@onready var reason = $CanvasLayer/popup/Reason
@onready var popname = $CanvasLayer/popup/Name
@onready var rule = $CanvasLayer/popup/Rule
@onready var type = $CanvasLayer/popup/Type
#important stuff
@onready var VerText = $CanvasLayer/Version
@onready var badge = $CanvasLayer/main/badge
#MENU STUFF
@onready var menub = $CanvasLayer/Menu
@onready var Menu = $CanvasLayer/Panel/MainButtonspanel/Menu
@onready var Settings = $CanvasLayer/Panel/MainButtonspanel/Settings
@onready var Feedback = $CanvasLayer/Panel/MainButtonspanel/Feedback
@onready var Graphics = $CanvasLayer/Panel/Settings/Graphics
@onready var Debug = $CanvasLayer/Panel/Settings/Debug
@onready var Leave = $CanvasLayer/Panel/Menu/Leave
@onready var Reset = $CanvasLayer/Panel/Menu/Reset
@onready var Feedbacktext = $CanvasLayer/Panel/Feedback/Feedbacktext
@onready var Send = $CanvasLayer/Panel/Feedback/Send
@onready var Bloom = $CanvasLayer/Panel/Graphics/Bloom
@onready var SSIL = $CanvasLayer/Panel/Graphics/SSIL
#get stuff ready
var disable = 0
var bpp = false
var infstamina = false
var Stamina_bar = 100
@export var version : String
var badgetexture = ''
var InitialHealth = 100
var chatter = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Chat.text += ('Voxopolis Ver ' + version + '\n')
	#Chat.text += ('THIS IS A TEST BUILD YOU MUST NOT SHARE THIS BUILD' + '\n')
	#Chat.text += ('WITH ANYONE.' + '\n')
	#Chat.add_item('This is a unstable build, bugs may occur.')
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		# Check if the click was outside the text box
		var click_position = event.position
		if not ChatTEXT.get_global_rect().has_point(click_position):
			# Release focus from the text box
			ChatTEXT.release_focus()
			disable = 0
			chatter = false
		if not StaminaSlider.get_global_rect().has_point(click_position):
			# Release focus from the text box
			StaminaSlider.release_focus()
			disable = 0
		if not TSS.get_global_rect().has_point(click_position):
			# Release focus from the text box
			TSS.release_focus()
			disable = 0
		if not JPS.get_global_rect().has_point(click_position):
			# Release focus from the text box
			JPS.release_focus()
			disable = 0
		if not SS.get_global_rect().has_point(click_position):
			# Release focus from the text box
			SS.release_focus()
			disable = 0
		if not FOV.get_global_rect().has_point(click_position):
			# Release focus from the text box
			FOV.release_focus()
			disable = 0
		if not HS.get_global_rect().has_point(click_position):
			# Release focus from the text box
			HS.release_focus()
			disable = 0
		if not infstaminab.get_global_rect().has_point(click_position):
			# Release focus from the text box
			infstaminab.release_focus()
			disable = 0

		if not menub.get_global_rect().has_point(click_position):
			# Release focus from the text box
			menub.release_focus()
			disable = 0

		if not Menu.get_global_rect().has_point(click_position):
			# Release focus from the text box
			Menu.release_focus()
			disable = 0

		if not Settings.get_global_rect().has_point(click_position):
			# Release focus from the text box
			Settings.release_focus()
			disable = 0

		if not Feedback.get_global_rect().has_point(click_position):
			# Release focus from the text box
			Feedback.release_focus()
			disable = 0

		if not Graphics.get_global_rect().has_point(click_position):
			# Release focus from the text box
			Graphics.release_focus()
			disable = 0

		if not Debug.get_global_rect().has_point(click_position):
			# Release focus from the text box
			Debug.release_focus()
			disable = 0

		if not Leave.get_global_rect().has_point(click_position):
			# Release focus from the text box
			Leave.release_focus()
			disable = 0

		if not Reset.get_global_rect().has_point(click_position):
			# Release focus from the text box
			Reset.release_focus()
			disable = 0

		if not Feedbacktext.get_global_rect().has_point(click_position):
			# Release focus from the text box
			Feedbacktext.release_focus()
			disable = 0

		if not Send.get_global_rect().has_point(click_position):
			# Release focus from the text box
			Send.release_focus()
			disable = 0

		if not Bloom.get_global_rect().has_point(click_position):
			# Release focus from the text box
			Bloom.release_focus()
			disable = 0

		if not SSIL.get_global_rect().has_point(click_position):
			# Release focus from the text box
			SSIL.release_focus()
			disable = 0
	if chatter == true:
		ChatTEXT.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	TS.text = "Turning Speed: " + str(TSS.value)
	S.text = "Speed: " + str(SS.value)
	JP.text = "Jump Power: " + str(JPS.value)
	FOVTEXT.text = "FOV: " + str(FOV.value)
	popname.text = "User: " + Name.text
	if $"..".position.y < -30:
		HS.value = 0
	Health = HS.value
	HealthText.text = "Health:" + str(Health)
	#VerText.text = 'UNSTABLE Ver ' + version
	VerText.text = 'TEST BUILD Ver ' + version
	var staminaprep = str(round(Stamina_bar))
	if infstamina == false:
		StaminaSlider.value = Stamina_bar
	else:
		StaminaSlider.value = Stamina_bar
	if infstamina == true:
		Stamina_bar = 100
	if Input.is_action_pressed("Run") and disable == 0:
		if infstamina == false:
			Stamina_bar -= 0.35
		if infstamina == true:
			Stamina_bar = 100
	else:
		Stamina_bar += 0.25
	if Stamina_bar > 100:
		Stamina_bar = 100
	if Stamina_bar < 0:
		Stamina_bar = 0
	pass
	if Input.is_action_pressed('chat'):
		chatter = true
	if Input.is_action_pressed('enter'):
		chatter = false
		ChatTEXT.release_focus()

func _on_okay_button_down():
	popup.visible = false
	pass # Replace with function body.

func _on_chat_text_text_changed(new_text):
	disable = 1
	pass # Replace with function body.


func _on_nick_edit_text_changed():
	disable = 1
	pass # Replace with function body.


func _on_check_button_button_down():
	if bpp == false:
		infstamina = true
		bpp = true
	else:
		infstamina = false
		bpp = false
	return infstamina
