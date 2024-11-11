extends CharacterBody2D

var speed: float = 7000#300.0
var acceleration: float = 0.1

func get_input_vector() -> Vector2:
	var input: Vector2 = Vector2()
	input.y = Input.get_axis("move_forward", "move_backward")
	input.x = Input.get_axis("move_left", "move_right")
	return input

func _physics_process(delta):
	var direction: Vector2 = get_input_vector()
	
	if direction.length() > 0:
		velocity = velocity.lerp(direction.normalized() * speed, acceleration)
	else:
		velocity = velocity.lerp(Vector2.ZERO, acceleration)
	
	move_and_slide()
