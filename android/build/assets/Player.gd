extends CharacterBody3D
@onready var camera = $Camera/ybone/xbone/Camera3D
@onready var cameraYbone = $Camera/ybone
@onready var cameraXbone = $Camera/ybone/xbone
@onready var cls = $"Camera/ybone/xbone/Camera3D/0"

#health
@onready var healthbar = $Sprite3D/CanvasLayer/HS

@onready var visuals = $Visuals
@onready var JumpSFX = $Visuals/JumpSFX
@onready var NameEdit = $Sprite3D/CanvasLayer/NickEdit
@onready var music = $music

#BONES
@onready var RightLeg = $Visuals/TorsoBone/RightLegBone
@onready var LeftLeg = $Visuals/TorsoBone/LeftLegBone
@onready var RightArm = $Visuals/TorsoBone/RightArmBone
@onready var LeftArm = $Visuals/TorsoBone/LeftArmBone
@onready var torso = $Visuals/TorsoBone
@onready var head = $Visuals/TorsoBone/HeadBone

#Meshes
@onready var RightLegmesh = $Visuals/TorsoBone/RightLegBone/Leg_Right
@onready var LeftLegmesh = $Visuals/TorsoBone/LeftLegBone/Leg_Left
@onready var RightArmmesh = $Visuals/TorsoBone/RightArmBone/Arm_Right
@onready var LeftArmmesh = $Visuals/TorsoBone/LeftArmBone/Arm_Left
@onready var torsomesh = $Visuals/TorsoBone/Torso
@onready var headmesh = $Visuals/TorsoBone/HeadBone/Head

#CHAT
@onready var Chat = $Sprite3D/CanvasLayer/Chat
@onready var ChatTEXT = $Sprite3D/CanvasLayer/ChatTEXT
@onready var Name = $Sprite3D/CanvasLayer/main/Nick

#Popup
@onready var popup = $Sprite3D/CanvasLayer/popup
@onready var accept = $Sprite3D/CanvasLayer/popup/okay
@onready var rule = $Sprite3D/CanvasLayer/popup/Rule
@onready var type = $Sprite3D/CanvasLayer/popup/Type
@onready var reason = $Sprite3D/CanvasLayer/popup/Reason
@onready var popname = $Sprite3D/CanvasLayer/popup/Name

#notifications
@onready var notif = $Sprite3D/CanvasLayer/notif
@onready var notiftitle = $Sprite3D/CanvasLayer/notif/Panel/title
@onready var notifdesc = $Sprite3D/CanvasLayer/notif/desc
@onready var notifcolor = $Sprite3D/CanvasLayer/notif/ColorRect
@onready var nametag = $Visuals/TorsoBone/HeadBone/Head/name
#Colors
@export var warningcol : Color = Color(255, 0, 0)
@export var normalcol : Color = Color(100, 100, 255)
@export var errorcol : Color = Color('#dbdb00')
#misc
@onready var msg = $Visuals/TorsoBone/HeadBone/Head/Message
var bpp = false
@export var infstamina : bool = false
var health = 100
var dancing = false
var edance = false
var scream = false
var orient = 0 # 179
var jumptax = 0 # 0.15
var mp = false
var stamina = 100
var CAMERAFOV = 70
var TURNSPEED = 15
@export  var SPEED : float = 12 / 4
@export var JUMP_VELOCITY : float = 25 / 4
var gravity = 20.0 
var count = 0
var time = 0
var tax = 0
var message = ""
var messageril = false
var dancecount = 0
var ypos = -6.3
var interpolation = 0
var SpatialMaterial = StandardMaterial3D
#clothing
var shirt = SpatialMaterial.new()
var shirttex = load("res://assets/newcharacter_shirttemplate.png")
var pants = SpatialMaterial.new()
var pantstex = load("res://assets/newcharacter_pantstemplate.png")

var removed = 0
var disable = 0

var timer = 0
var texting = false
@onready var board = $Sprite3D/CanvasLayer/name
@export var spawnpoint : Vector3 = self.position
var sb = false
var pb = false
var timeh = 0
var timehl = 0
@onready var file_dialog = $Sprite3D/CanvasLayer/FileDialog
signal transfer_msg(message)
#Multiplayer
func _enter_tree():
	set_multiplayer_authority(name.to_int())
#	leaderboard(name)

#func leaderboard(name):
#	var server = get_parent()
#	var children = server.get_children()
#	var y = 41
#	for i in children:
#		if i == CharacterBody3D:
#			var board = $Sprite3D/CanvasLayer/name.duplicate()
#			if i.name != name:
#				add_child(board)
#				y = y + 50
#				board.y = y
#				board.Nick.text = name
#				
func _ready():
	file_dialog.add_filter("*.png", "Images")
	camera.current = is_multiplayer_authority()
	nametag.text = name
	msg.text = ''

func notifsend(title, desc, val, time):
	notif.visible = true
	notiftitle.text = title
	notifdesc.text = desc

func warn(reasonb, ruleb):
	popup.visible = true
	rule.text = "Rule Broken: " + ruleb
	reason.text = "Reason: " + reasonb
	type.text = 'Warning!'

func ban(reasonb, ruleb):
	popup.visible = true
	rule.text = "Rule Broken: " + ruleb
	reason.text = "Reason: " + reasonb
	type.text = 'Ban hammer has spoken.'

func send_message(message):
	if message != "":
		ChatTEXT.text = ""  # Clear the input field
		var messagefull = str(Name.text + ": " + message + "\n")
		messageril = true
		var id = str(Name.text)
		Chat.text += messagefull
		get_parent()._transfer_msg(message, id)
		fetchplayers(id)
		return message

func messagefromserver(message, id):
	var messagefull = str(id + ": " + message + "\n")
	Chat.text += messagefull

func fetchplayers(id):
	get_parent().fetchplayers(id)

func leaderboard(i,y):
	var clc =  $Sprite3D/CanvasLayer.get_children()
	for v in clc:
		if v.name == 'namechild':
			$Sprite3D/CanvasLayer.remove_child(v)
	var boardclone = board.duplicate()
	var bc = boardclone.get_children()
	$Sprite3D/CanvasLayer.add_child(boardclone)
	boardclone.name = 'namechild'
	boardclone.visible = true
	for o in bc:
		if o.name == 'Nick':
			o.text = i.name
		if o.name == 'badge':
			if i.name != '1':
				o.visible = false
			else:
				o.visible = true
	boardclone.position = Vector2(board.position.x, y)

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		# Check if the click was outside the text box
		var click_position = event.position
		if not ChatTEXT.get_global_rect().has_point(click_position):
			# Release focus from the text box
			ChatTEXT.release_focus()
			disable = 0
		if ChatTEXT.get_global_rect().has_point(click_position):
			disable = 1
		if not NameEdit.get_global_rect().has_point(click_position):
			# Release focus from the text box
			NameEdit.release_focus()
			disable = 0
		if NameEdit.get_global_rect().has_point(click_position):
			disable = 1

var fps = 0
var frame = 0
func _physics_process(delta):
	if is_multiplayer_authority():
		fetchplayers(name)
		health = $Sprite3D.Health
		timeh += 0.15
		timehl += 0.15
		if messageril == true:
			msg.text = message
			get_parent().headmessage(message, name, msg)
			if floor(timeh) == 20:
				messageril = false
				msg.text = ''
				get_parent().headmessage('', name, msg)
		else:
			msg.text = ''
			timeh = 0
		if health == 0:
			if floor(timeh) == 20:
				health = 100
				self.position = spawnpoint
		else:
			timehl = 0
		if Input.is_action_just_pressed("quit"):
			$"../".exit_game(name.to_int())
		$Sprite3D/CanvasLayer/main/Nick.text = name
		if name != "1":
			$Sprite3D/CanvasLayer/main/badge.visible = false
		#textures
		pants.albedo_texture = pantstex
		LeftLegmesh.material_override = pants
		RightLegmesh.material_override = pants
		shirt.albedo_texture = shirttex
		torsomesh.material_override = shirt
		LeftArmmesh.material_override = shirt
		RightArmmesh.material_override = shirt
		if infstamina == true:
			stamina = 100
		if not is_on_floor():
			time += 0.1
			velocity.y -= gravity * delta
			if time > 1.5:
				tax = 1
				if orient != -3:
					if orient < -3:
						orient = -3
					if orient > -3:
						orient -= 0.5
		else:
			if orient != 0:
				if orient > 0:
					orient = 0
				if orient < 0:
					interpolation = 1
					orient += 0.5
			else:
				interpolation = 0
			time = 0
			tax = 0
		var text = ChatTEXT.text
		var text2 = NameEdit.text
		var new_text = ''
		if "\n" in str(NameEdit.text):
			if (NameEdit.text == '' or NameEdit.text == null):
				NameEdit.text = "Invalid"
			else:
				if not (' ' in NameEdit.text or '' in NameEdit.text):
					new_text = str(NameEdit.text).replace("\n","")
					NameEdit.text = str(new_text)
					Name.text = NameEdit.text
					popname.text = "User: " + Name.text
					NameEdit.text = ''
				else:
					NameEdit.text = "Invalid"
		if not (' ' in text or ' ' in text2):
			if Input.is_action_pressed("jump") and is_on_floor() and disable == 0:
				velocity.y = JUMP_VELOCITY
				JumpSFX.play()
		
		var input_dir = Vector3(0,0,0)
		if disable == 0:
			input_dir = Input.get_vector("left", "right", "down", "up")
		var cam_transform = camera.global_transform
		var cam_squidward = -cam_transform.basis.z.normalized()
		var camfwy = cam_squidward.y
		var cam_forward = Vector3(cam_squidward.x,camfwy,cam_squidward.z)
		var cam_right = cam_transform.basis.x.normalized()

		# Ignore the vertical component of the camera's forward and right vectors
		cam_right.y = 0

		var direction = cam_forward * input_dir.y + cam_right * input_dir.x
		if cls.name == '1':
			visuals.rotation.y = atan2(cam_forward.x, cam_forward.z)
		if dancing == true:
			if edance == true:
				if direction:
					Chat.text += "Emote stopped due movement. \n"
					edance = false
					dancing = false
				if scream == true:
					edance = false
				dancecount += 0.24
				if dancecount > 6:
					dancecount = 0
				RightArm.position = Vector3(-1.5, -sin(count)/(1.85+1/2)/1.2+1.4, 0)
				LeftArm.position = Vector3(0.5, sin(count)/(1.85+1/2)/1.2+1.4, 0)
				RightArm.rotation = Vector3(80,0,0)
				LeftArm.rotation = Vector3(80,0,0)
			if scream == true:
				if edance == true:
					scream = false
				dancecount += 0.24
				if dancecount > 6:
					dancecount = 0
				RightArm.rotation = Vector3(-sin(count)/(1.85+1/2)+179, 0, 0)
				LeftArm.rotation = Vector3(sin(count)/(1.85+1/2)+179, 0, 0)
		if direction.length() > 0.01:
			count += 0.24
			if count > 6:
				count = 0
		else:
			if is_on_floor():
				if dancing == false:
					count = 3
					RightLeg.rotation = Vector3(0, 0, 0)
					LeftLeg.rotation = Vector3(0, 0, 0)
					RightArm.rotation = Vector3(0, 0, 0)
					LeftArm.rotation = Vector3(0, 0, 0)
					RightLeg.position = Vector3(-1, 0, 0)
					LeftLeg.position = Vector3(0, 0, 0)
					RightArm.position = Vector3(-1.5, 1.7, 0)
					LeftArm.position = Vector3(0.5, 1.7, 0)
				if dancing == true:
					count += 0.24
					if count > 6:
						count = 0
			else: 
				count += 0.24
				if count > 6:
					count = 0
				if scream == false:
					RightArm.rotation = Vector3(-sin(count)/(1.8+tax/2)+orient, 0, 0)
					LeftArm.rotation = Vector3(sin(count)/(1.8+tax/2)+orient, 0, 0)
		if Input.is_action_pressed("Run") and disable == 0:
			if direction.length() > 0.01:
				if stamina > 0.05:
					#run
					if SPEED > 39.5/4:
						RightLeg.rotation = Vector3(sin(count)/0.5, 0, 0)
						LeftLeg.rotation = Vector3(-sin(count)/0.5, 0, 0)
						if scream == false:
							RightArm.rotation = Vector3(-sin(count)/(0.68+tax)+orient, 0, 0)
							LeftArm.rotation = Vector3(sin(count)/(0.68+tax)+orient, 0, 0)
					else:
						RightLeg.rotation = Vector3(sin(count)/0.65, 0, 0)
						LeftLeg.rotation = Vector3(-sin(count)/0.65, 0, 0)
						if scream == false:
							RightArm.rotation = Vector3(-sin(count)/(0.7+tax)+orient, 0, 0)
							LeftArm.rotation = Vector3(sin(count)/(0.7+tax)+orient, 0, 0)
				else:
					#walk
					if SPEED > 39.5/4:
						RightLeg.rotation = Vector3(sin(count)/0.85, 0, 0)
						LeftLeg.rotation = Vector3(-sin(count)/0.85, 0, 0)
						if scream == false:
							RightArm.rotation = Vector3(-sin(count)/(0.9+tax/2)+orient, 0, 0)
							LeftArm.rotation = Vector3(sin(count)/(0.9+tax/2)+orient, 0, 0)
					else:
						RightLeg.rotation = Vector3(sin(count)/1.8, 0, 0)
						LeftLeg.rotation = Vector3(-sin(count)/1.8, 0, 0)
						if scream == false:
							RightArm.rotation = Vector3(-sin(count)/(1.65+tax/2)+orient, 0, 0)
							LeftArm.rotation = Vector3(sin(count)/(1.65+tax/2)+orient, 0, 0)
			stamina -= 0.35
		else:
			if direction.length() > 0.01:
				#walk
				if SPEED > 39.5/4:
					RightLeg.rotation = Vector3(sin(count)/0.85, 0, 0)
					LeftLeg.rotation = Vector3(-sin(count)/0.85, 0, 0)
					if scream == false:
						RightArm.rotation = Vector3(-sin(count)/(0.9+tax/2)+orient, 0, 0)
						LeftArm.rotation = Vector3(sin(count)/(0.9+tax/2)+orient, 0, 0)
				else:
					RightLeg.rotation = Vector3(sin(count)/1.8, 0, 0)
					LeftLeg.rotation = Vector3(-sin(count)/1.8, 0, 0)
					if scream == false:
						RightArm.rotation = Vector3(-sin(count)/(1.65+tax/2)+orient, 0, 0)
						LeftArm.rotation = Vector3(sin(count)/(1.65+tax/2)+orient, 0, 0)
			stamina += 0.25
		if stamina > 100:
			stamina = 100
		if stamina < 0:
			stamina = 0
		if direction.length() > 0.01:  # Check if there's a significant input
			var target_rotation = atan2(direction.x, direction.z)
			
			# Rotate the entire "Visuals" node
			if cls.name == '0':
				visuals.rotation.y = lerp_angle(visuals.rotation.y, target_rotation, TURNSPEED * delta)

			if Input.is_action_pressed("Run") and stamina > 0.05 and disable == 0:
				camera.fov = CAMERAFOV + 20
				velocity.x = direction.x * SPEED * 2
				velocity.z = direction.z * SPEED * 2
			else:
				camera.fov = CAMERAFOV
				velocity.x = direction.x * SPEED
				velocity.z = direction.z * SPEED

			if stamina < 0:
				camera.fov = CAMERAFOV
		else:
			if Input.is_action_pressed("Run") and stamina > 0 and disable == 0:
				camera.fov = CAMERAFOV + 20
				velocity.x = move_toward(velocity.x, 0, SPEED * 2)
				velocity.z = move_toward(velocity.z, 0, SPEED * 2)
			else:
				camera.fov = CAMERAFOV
				velocity.x = move_toward(velocity.x, 0, SPEED)
				velocity.z = move_toward(velocity.z, 0, SPEED)

			if stamina < 0.06:
				camera.fov = CAMERAFOV
		move_and_slide()
	else:
		if removed == 0:
			remove_child($Sprite3D)
			removed = 1

func _on_ss_value_changed(value):
	SPEED = value / 4

func _on_jps_value_changed(value):
	JUMP_VELOCITY = value / 4

func _on_tss_value_changed(value):
	TURNSPEED = value

func _on_fov_value_changed(value):
	CAMERAFOV = value


func _on_check_button_button_down():
	if bpp == false:
		infstamina = true
		bpp = true
	else:
		infstamina = false
		bpp = false
	return infstamina


func _on_chat_text_text_submitted(new_text):
	new_text = str(ChatTEXT.text).replace("\n","")
	ChatTEXT.text = str(new_text)
	if ChatTEXT.text != '':
		#commands
		if ChatTEXT.text != '/e scream':
			if ChatTEXT.text != '/help':
				if ChatTEXT.text != '/music':
					if ChatTEXT.text != '/banself':
						if ChatTEXT.text != '/warnself':
							if ChatTEXT.text != '/e dance':
								if ChatTEXT.text != '/e stop':
									message = ChatTEXT.text
									send_message(message)
								else:
									if dancing == true:
										Chat.text += 'Emote stopped via command. \n'
										dancing = false
										scream = false
										edance = false
							else:
								edance = true
								dancing = true
						else:
							warn('This is a test of popup panel, this will be obviously removed, none of this will actually happen rn, chillax', 'TEST')
					else:
						ban("This is a test of popup panel, this will be obviously removed, you aren't actually banned, chillax.", 'TEST')
				else:
					if mp == false:
						mp = true
						music.play()
					else:
						mp = false
						music.stop()
			else:
				Chat.text += ('_.-HELP-._' + '\n')
				Chat.text += ("EMOTES" + '\n')
				Chat.text += ('/e scream' + '\n')
				Chat.text += ('/e dance' + '\n')
				Chat.text += ("OTHER" + '\n')
				Chat.text += ('/music' + '\n')
				Chat.text += ('/banself' + '\n')
				Chat.text += ('/warnself' + '\n')
		else:
			scream = true
			dancing = true
		ChatTEXT.text = ''
	return message


func _on_shirt_pressed():
	sb = true
	file_dialog.popup_centered()
	pass # Replace with function body.


func _on_pants_pressed():
	pb = true
	file_dialog.popup_centered()
	pass # Replace with function body.


func _on_file_dialog_file_selected(path):
	var image_texture = ResourceLoader.load(path)
	if sb == true:
		shirttex = image_texture
		shirt.albedo_texture = shirttex
		torsomesh.material_override = shirt
		LeftArmmesh.material_override = shirt
		RightArmmesh.material_override = shirt
		sb = false
	if pb == true:
		pantstex = image_texture
		pants.albedo_texture = pantstex
		LeftLegmesh.material_override = pants
		RightLegmesh.material_override = pants
		pb = false
	pass # Replace with function body.


func _on_button_pressed():
	pass # Replace with function body.


func _on_nick_edit_text_changed():
	disable = 1
	pass # Replace with function body.


func _on_chat_text_text_changed(new_text):
	disable = 1
	pass # Replace with function body.


func _on_transfer_msg(message):
	Chat.text += message
	pass # Replace with function body.
