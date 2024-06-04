extends VBoxContainer
@onready var Feedbacktext = $Feedbacktext
func _on_send_pressed():
	var debugtext = ''
	if OS.is_debug_build():
		debugtext = ' (DEBUG)'
	var data_to_send = {
		"content":null,
		"embeds":[
			{"title":"**APB Feedback**",
			"description":Feedbacktext.text,
			"color":randi_range(1111111,9999999),
			"author":{
				"name":$"../../main/Name".text +"\n"+$"../../main/Nick".text
				},
			"footer":{
				"text":"Voxopolis v" + $"../../..".version + debugtext
				},
				}
			]
	}
	var json = JSON.stringify(data_to_send)
	var headers = ["Content-Type: application/json"]
	var url = 'https://discord.com/api/webhooks/1199314025226440724/BEi-ngJyhcvXWnTkRCUKmV2UbqMikvPDc81rlFj7iLHOWq5739HZbKBVz4SYR4uiTrhA'
	$HTTPRequest.request(url, headers, HTTPClient.METHOD_POST, json)
	$Feedbacktext.text = ''
	pass # Replace with function body.
