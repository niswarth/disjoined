class_name Item extends Node

var id: int

var item_name: String
var item_number: int
var item_type: Globals.types
var special_function

var icon_texture: Texture

signal recevied

func _init(id):
	var item_config: Dictionary = Globals.item_configs[id]
	item_name = item_config['name']
	item_number = item_config['number']
	item_type = item_config['type']
	
	icon_texture = load(item_config['icon_path'])

func _on_recevied():
	emit_signal(&'recieved')
