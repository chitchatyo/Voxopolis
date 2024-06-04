extends Camera3D

# Speed of camera rotation
var rotation_speed = 0.2

# Reference to the player node (assuming it's Node3D)
var player : Node3D

func _ready():
	# Get the parent of the Camera3D node
	var parent_node = get_parent()

	# Check if the parent is a Node3D
	if parent_node is Node3D:
		player = parent_node

	# Capture the mouse
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		var rotation_input = event.relative
		rotate_camera(rotation_input)

func rotate_camera(rotation_input):
	# Rotate the camera around the player
	rotate_y(rotation_input.x * rotation_speed)

	# Limit the camera's vertical rotation
	var new_rotation = rotation_degrees.x - rotation_input.y * rotation_speed
	new_rotation = clamp(new_rotation, -80, 80)  # Adjust the angle limits as needed
	rotation_degrees.x = new_rotation

	# Set the camera position relative to the player
	var offset = Vector3(0, 5, 15)  # Adjust the offset as needed
	var rotation_rad = deg_to_rad(rotation_degrees.x)
	var new_transform = Transform3D(Basis(Vector3.UP, rotation_rad), player.global_transform.origin + player.translation + offset)
	global_transform = new_transform
