extends Camera3D

var sensitivity = 0.2
var ctrl_lock = false
var alr = false
var disable = 0
var disableurgent = 0
var zoom = 3
var min_zoom = 0  # Adjust as needed
var max_zoom = 5  # Adjust as needed

@onready var xbone = $".." # Adjust the path as needed
@onready var Feedbacktext = $"../../../../Sprite3D/CanvasLayer/Panel/Feedback/Feedbacktext"
@onready var ChatTEXT = $"../../../../Sprite3D/CanvasLayer/ChatTEXT"
@onready var NameEdit = $"../../../../Sprite3D/CanvasLayer/NickEdit"
@onready var ybone = $"../.."    # Adjust the path as needed
@onready var cambone = $"../../.."
@onready var ctrllockimg = $"../../../../Sprite3D/CanvasLayer/ctrllock"
@onready var cls = $"0"
@onready var cam = $"."
@onready var torso = $"../../../../Visuals/TorsoBone/Torso"
@onready var head = $"../../../../Visuals/TorsoBone/HeadBone/Head"
@onready var lleg = $"../../../../Visuals/TorsoBone/LeftLegBone/Leg_Left"
@onready var rleg = $"../../../../Visuals/TorsoBone/RightLegBone/Leg_Right"
@onready var larm = $"../../../../Visuals/TorsoBone/LeftArmBone/Arm_Left"
@onready var rarm = $"../../../../Visuals/TorsoBone/RightArmBone/Arm_Right"

func _input(event):
	if is_multiplayer_authority():
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
			if not Feedbacktext.get_global_rect().has_point(click_position):
				# Release focus from the text box
				Feedbacktext.release_focus()
				disable = 0
			if Feedbacktext.get_global_rect().has_point(click_position):
				disable = 1
		if disableurgent == 1:
			disable = 1
		if event is InputEventMouseButton:
			if not ctrl_lock:
				if event.button_index == MOUSE_BUTTON_RIGHT:
					if event.pressed:
						Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
					else:
						Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		if event is InputEventScreenTouch:
			if not ctrl_lock:
				if event.pressed:
					$"../../../..".messagefromserver(str(event.position),'SERVER')
		elif event is InputEventMouseMotion or event is InputEventScreenDrag:
			if ctrl_lock or Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED or zoom == 0:
				if disable == 0:
					var rotation_change
					if event is InputEventMouseMotion:
						rotation_change = -event.relative * sensitivity
					else:
						rotation_change = -event.relative * sensitivity / 10.0
					xbone.rotate_x(deg_to_rad(rotation_change.y))
					ybone.rotate_y(deg_to_rad(rotation_change.x))
		elif event is InputEventScreenTouch:
			if not ctrl_lock:
				if event.pressed:
					$"../../../..".messagefromserver(str(event.position),'SERVER')
		elif Input.is_action_just_pressed("mouse_wheel_up") and zoom > min_zoom and disable == 0:
			if disable == 0:
				zoom -= 0.5
				zoom = clamp(zoom, min_zoom, max_zoom)
				var zoom_vector = Vector3(0, 0, -1)
				translate(zoom_vector)
		elif Input.is_action_just_pressed("mouse_wheel_down") and zoom < max_zoom and disable == 0:
			if disable == 0:
				zoom += 0.5
				zoom = clamp(zoom, min_zoom, max_zoom)
				var zoom_vector = Vector3(0, 0, 1)
				translate(zoom_vector)

func _process(_delta):
	if is_multiplayer_authority():
		if zoom == 0:
			torso.visible = false
			head.visible = false
			larm.visible = false
			rarm.visible = false
			lleg.visible = false
			rleg.visible = false
			cls.name = '1'
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			if not ctrl_lock or Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
				torso.visible = true
				head.visible = true
				larm.visible = true
				rarm.visible = true
				lleg.visible = true
				rleg.visible = true
				cls.name = '0'
		if ctrl_lock and disable == 0:
			cls.name = '1'
			cambone.position.x = 0.35
			ybone.position.x = -0.35
			xbone.position.x = 0.35
			cambone.position.y = 1.6
			ctrllockimg.visible = true
		else:
			if zoom != 0:
				cls.name = '0'
			cambone.position.x = 0
			ybone.position.x = 0
			xbone.position.x = 0
			cambone.position.y = 1.5
			ybone.position.y = 0
			xbone.position.y = 0
			ctrllockimg.visible = false
		if Input.is_action_just_pressed("CTRL") and disable == 0:
			if alr == false:
				if ctrl_lock == false:
					Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
					ctrl_lock = true
					alr = true
				else:
					if alr == false:
						Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
						ctrl_lock = false

		if Input.is_action_just_released("CTRL") and disable == 0:
			if alr == true:
				alr = false

func _on_nick_edit_text_changed():
	disable = 1
	pass # Replace with function body.

func _on_chat_text_text_changed(new_text):
	disable = 1
	pass # Replace with function body.

func _on_chat_mouse_entered():
	disableurgent = 1
	pass # Replace with function body.

func _on_chat_mouse_exited():
	disableurgent = 0
	pass # Replace with function body.

func _on_chat_text_mouse_entered():
	disableurgent = 1
	pass # Replace with function body.

func _on_chat_text_mouse_exited():
	disableurgent = 0
	pass # Replace with function body.
