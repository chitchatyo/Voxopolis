extends Node

var displaynameofplayer = ''
var peer = ENetMultiplayerPeer.new()
@export var player_scene : PackedScene
@onready var address = $CanvasLayer/Address

func _ready():
	var cmd_args = OS.get_cmdline_args()
	print("Command Line Arguments:", cmd_args)
	
	if cmd_args.size() > 0:
		var url = cmd_args[0]
		print("Received URL:", url)
		if url.begins_with("voxopolis:"):
			var base64_param = url.substr(9)
			print("Base64 Parameter:", base64_param)
			var decoded_text = Marshalls.base64_to_utf8(base64_param)
			print("Decoded Text:", decoded_text)
			$CanvasLayer/decoded.text = decoded_text
			$CanvasLayer/base64.text = base64_param
		else:
			print("Invalid URL format")
			var base64_param = url
			print("Base64 Parameter:", base64_param)
			var decoded_text = Marshalls.base64_to_utf8(base64_param)
			print("Decoded Text:", decoded_text)
			$CanvasLayer/decoded.text = "Welcome Back, " + decoded_text + '!'

func _on_host_pressed():
	peer.set_bind_ip(str(address.text))
	peer.create_server(1027,25)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(add_player)
	add_player()
	$CanvasLayer.hide()

func _on_connect_pressed():
	peer.create_client(address.text,1027)
	multiplayer.multiplayer_peer = peer
	$CanvasLayer.hide()

func exit_game(id):
	multiplayer.peer_disconnected.connect(del_player)
	del_player(id)

func add_player(id = 1):
	var player = player_scene.instantiate()
	player.name = str(id)
	call_deferred("add_child",player)

func headmessage(message, id, Message):
	rpc('_headmessage',message, id, Message)

@rpc("any_peer", 'call_local')
func _headmessage(message, id, Message):
	get_node(str(id)).get_node('Visuals').get_node('TorsoBone').get_node('HeadBone').get_node('Head').get_node('Message').text = message

func fetchplayers(id):
	var y = 41
	var players = get_children()
	for i in players:
		var iclass = i.get_class()
		if iclass == 'CharacterBody3D':
			if i.name != id:
				if 'Platform' not in i.name:
					y += 50
					get_node(str(id)).leaderboard(i,y)

func _transfer_msg(message, DisplayName, id):
	rpc("transfer_msg",message, DisplayName, id)

@rpc("any_peer", "call_local", "reliable")
func transfer_msg(message, DisplayName, id):
	var players = get_children()
	for i in players:
		var iclass = i.get_class()
		if iclass == 'CharacterBody3D':
			if i.name != id:
				if 'Platform' not in i.name:
					get_node(str(i.name)).messagefromserver(message, DisplayName ,id)

func del_player(id):
	get_tree().quit()
	rpc("_del_player",id)

@rpc("any_peer","call_local")
func _del_player(id):
	get_node(str(id)).queue_free()


func _on_display_name_text_changed():
	displaynameofplayer = $CanvasLayer/DisplayName.text
	pass # Replace with function body.
