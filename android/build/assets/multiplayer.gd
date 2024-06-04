extends Node

var peer = ENetMultiplayerPeer.new()
@export var player_scene : PackedScene
@onready var address = $CanvasLayer/Address

func _on_host_pressed():
	peer.create_server(1027)
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
				y += 50
				get_node(str(id)).leaderboard(i,y)

func _transfer_msg(message, id):
	rpc("transfer_msg",message, id)

@rpc("any_peer", "call_local", "reliable")
func transfer_msg(message, id):
	var players = get_children()
	for i in players:
		var iclass = i.get_class()
		if iclass == 'CharacterBody3D':
			if i.name != id:
				get_node(str(i.name)).messagefromserver(message, id)

func del_player(id):
	get_tree().quit()
	rpc("_del_player",id)

@rpc("any_peer","call_local")
func _del_player(id):
	get_node(str(id)).queue_free()
