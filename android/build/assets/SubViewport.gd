extends SubViewport
@onready var Stamina = $Stamina
@onready var Apply = $Apply
@onready var EditName = $NickEdit
@onready var Name = $Nick
@onready var StaminaSlider = $Slider
#CHAT
@onready var Chat = $Chat
@onready var ChatTEXT = $ChatTEXT
#SLIDERS
@onready var TSS = $TSS
@onready var JPS = $JPS
@onready var SS = $SS
@onready var FOV = $FOV
#VALUES
@onready var TS = $TS
@onready var JP = $JP
@onready var S = $S
@onready var FOVTEXT = $FOVTEXT
#Define the Popup
@onready var popup = $popup
@onready var accept = $popup/okay
@onready var reason = $popup/Reason
@onready var popname = $popup/Name
@onready var rule = $popup/Rule
@onready var type = $popup/Type
#important stuff
@onready var VerText = $Version
@onready var badge = $badge
#get stuff ready
var Stamina_bar = 100
var version = '1.6.1'
var badgetexture = badge.texture.get_path()

func warn(reasonb, ruleb):
	rule.text = "Rule Broken: " + ruleb
	reason.text = "Reason: " + reasonb
	type.text = 'Warning!'

func ban(reasonb, ruleb):
	rule.text = "Rule Broken: " + ruleb
	reason.text = "Reason: " + reasonb
	type.text = 'Ban hammer has spoken.'

# Called when the node enters the scene tree for the first time.
func _ready():
	Chat.add_item('APlayBox Ver ' + version + ' Chatting System By BStarsAlex')
	Chat.add_item('THIS IS A TEST BUILD YOU MUST NOT SHARE THIS BUILD')
	Chat.add_item('WITH ANYONE.')
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	TS.text = "Turning Speed: " + str(TSS.value)
	S.text = "Speed: " + str(SS.value)
	JP.text = "Jump Power: " + str(JPS.value)
	FOVTEXT.text = "FOV: " + str(FOV.value)
	popname.text = "User: " + Name.text
	VerText.text = 'TEST BUILD Ver.' + version
	var staminaprep = str(round(Stamina_bar))
	Stamina.text = "Stamina: " + staminaprep
	StaminaSlider.value = Stamina_bar
	
	if Input.is_action_pressed("Run"):
		Stamina_bar -= 0.35
	else:
		Stamina_bar += 0.15
	if Stamina_bar > 100:
		Stamina_bar = 100
	if Stamina_bar < 0:
		Stamina_bar = 0
	pass


func _on_apply_button_down():
	if EditName.text == '':
		EditName.text = "Invalid"
	else:
		Name.text = EditName.text
		popname.text = "User: " + Name.text
		EditName.text = ''
	pass # Replace with function body.


func _on_okay_button_down():
	pass # Replace with function body.


func _on_send_button_down():
	if ChatTEXT.text != '':
		#commands
		if ChatTEXT.text != '/e dance':
			if ChatTEXT.text != '/help':
				Chat.add_item(Name.text + ": " + ChatTEXT.text, badgetexture)
			else:
				Chat.add_item('_.-HELP-._')
				Chat.add_item("there isn't much here, only /e dance")
				Chat.add_item("and /music")
		else:
			Chat.add_item('[*DANCE*]')
		ChatTEXT.text = ''
	pass # Replace with function body.
