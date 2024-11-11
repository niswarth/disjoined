extends Node2D

var id: int
var size: float

@onready var floor_texture: TextureRect = $FloorTexture
@onready var floor_id_label: Label = $FloorIdLabel

func _ready():
	self.name = "floor_" + str(id)
	
	floor_texture.size.x = size
	floor_texture.size.y = size
	
	# TESTING
	floor_id_label.text = str(id)
