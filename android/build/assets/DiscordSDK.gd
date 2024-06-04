extends Node

@onready var version = $"../Sprite3D".version
@onready var img = preload("res://assets/R (1).jpg")
# Called when the node enters the scene tree for the first time.
func _ready():
	DiscordSDK.app_id = 911731423101198366
	# Now 'image' contains the pixel data from the compressed texture
	if OS.is_debug_build():
		DiscordSDK.details = "Playing APlayBox (DEBUG) v" + version
		DiscordSDK.large_image_text = "Coding/Testing (Probably)"
		DiscordSDK.large_image = "debug"
	else:
		DiscordSDK.details = "Playing APlayBox v" + version
		DiscordSDK.large_image = "normal"

	DiscordSDK.start_timestamp = int(Time.get_unix_time_from_system())
	DiscordSDK.refresh()
