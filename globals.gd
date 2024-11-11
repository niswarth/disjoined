extends Node

enum types {BLACK, RED, BANAMBA, YELLOW}

var item_configs: Array = [
	{'name': 'test', 'number': 0, 'type': types.BLACK, 'icon_path': ^'res://icon.svg'},
	{'name': 'test', 'number': 0, 'type': types.BLACK, 'icon_path': ^'res://icon.svg'},
	{'name': 'test', 'number': 0, 'type': types.BLACK, 'icon_path': ^'res://icon.svg'},
]

var game_state: Dictionary = {}

func _ready():
	# TODO: Remove the saving when the game is done vvvv
	save_item_config()
	# TODO: REMOVE ON RELEASE IDIOT ^^^^
	load_item_config()

# TEST: Untested bc unwork
func save_game(save_file: int) -> void:
	var file: FileAccess = FileAccess.open("user://game_state_%s.conf" % [save_file], FileAccess.WRITE)
	file.store_string(var_to_str(game_state))
	file.close()

# TEST: Untested bc unwork
func load_game(save_file: int) -> void:
	var file: FileAccess = FileAccess.open("user://game_state_%s.conf" % [save_file], FileAccess.READ)
	game_state = str_to_var(file.get_as_text())
	file.close()

# Save everything from item_configs to the item_configs.conf file
func save_item_config() -> void:
	var file: FileAccess = FileAccess.open("res://item_config.conf", FileAccess.WRITE)
	
	var content: String = ""
	for item in item_configs:
		var item_string: String = ""
		for field in item:
			item_string += field + "::" + var_to_str(item[field]) + ("," if field != item.keys()[-1] else "\n")
		content += item_string
	
	file.store_string(content)
	file.close()

# Load from item_configs.conf file and store in item_configs
func load_item_config() -> void:
	var file: FileAccess = FileAccess.open("res://item_config.conf", FileAccess.READ)
	var items: Array = file.get_as_text().split('\n')
	file.close()
	
	item_configs = []
	for item in items:
		var item_fields: Array = item.split(',')
		var item_dictionary: Dictionary = {}
		for field in item_fields.slice(0, -1):
			item_dictionary[field.split('::')[0]] = str_to_var(field.split('::')[1])
		
		item_configs.append(item_dictionary)
