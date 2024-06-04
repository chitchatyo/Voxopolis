extends SubViewport
@onready var Stamina = $Stamina
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
@onready var HS = $HS
@onready var Health = HS.value
#VALUES
@onready var TS = $TS
@onready var JP = $JP
@onready var S = $S
@onready var FOVTEXT = $FOVTEXT
@onready var HealthText = $Health
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
var bpp = false
var infstamina = false
var Stamina_bar = 100
var version = '2.4.0'
var badgetexture = ''
var InitialHealth = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	Chat.add_item('APlayBox Ver ' + version)
	Chat.add_item('THIS IS A TEST BUILD YOU MUST NOT SHARE THIS BUILD')
	Chat.add_item('WITH ANYONE.')
	#Chat.add_item('This is a unstable build, bugs may occur.')
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	TS.text = "Turning Speed: " + str(TSS.value)
	S.text = "Speed: " + str(SS.value)
	JP.text = "Jump Power: " + str(JPS.value)
	FOVTEXT.text = "FOV: " + str(FOV.value)
	popname.text = "User: " + Name.text
	if HS.value < 1:
		HS.value = InitialHealth
	Health = HS.value
	HealthText.text = "Health:" + str(Health)
	#VerText.text = 'UNSTABLE Ver ' + version
	VerText.text = 'TEST BUILD Ver ' + version
	var staminaprep = str(round(Stamina_bar))
	if infstamina == false:
		Stamina.text = "Stamina: " + staminaprep
		StaminaSlider.value = Stamina_bar
	else:
		Stamina.text = "Stamina: INF"
		StaminaSlider.value = Stamina_bar
	if infstamina == true:
		Stamina_bar = 100
	if Input.is_action_pressed("Run"):
		if infstamina == false:
			Stamina_bar -= 0.35
		else:
			Stamina_bar = 100
	else:
		Stamina_bar += 0.15
	if Stamina_bar > 100:
		Stamina_bar = 100
	if Stamina_bar < 0:
		Stamina_bar = 0
	pass

func _on_okay_button_down():
	popup.visible = false
	pass # Replace with function body.


func _on_check_button_button_down():
	if bpp == false:
		infstamina = true
		bpp = true
	else:
		infstamina = false
		bpp = false
	return infstamina
