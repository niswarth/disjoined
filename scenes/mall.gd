extends Node2D

var escalator_length: float = 200.0
var floor_size: float = 1000.0

var floor_scene := preload("res://scenes/support/mall_floor.tscn")

var current_floor: int = 0
var loaded_floors: Dictionary = {}
var loading_distance: int = 3
@onready var player: CharacterBody2D = $Player

func _process(_delta):
	current_floor = get_floor(player.global_position)
	
	for i in loading_distance:
		if i + current_floor not in loaded_floors:
			load_floor(i + current_floor)
		if i - current_floor not in loaded_floors:
			load_floor(i - current_floor)
	
	for floor in loaded_floors:
		if abs(floor - current_floor) > loading_distance:
			unload_floor(floor)

func get_floor(pos: Vector2) -> int:
	return floor(pos.y / -(floor_size + escalator_length)) + 1

func load_floor(id: int) -> void:
	var floor_instance := floor_scene.instantiate()
	
	floor_instance.id = id
	floor_instance.size = floor_size
	
	floor_instance.global_position.y = -(floor_size * id + escalator_length * id)
	
	self.add_child(floor_instance)
	loaded_floors[id] = floor_instance

func unload_floor(id: int) -> void:
	get_node('floor_' + str(id)).queue_free()
	loaded_floors.erase(id)
