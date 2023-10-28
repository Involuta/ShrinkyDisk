extends CharacterBody2D

var alive = true

const acc = 5
const turn_speed = .05
const base_max_speed = 500
const boost_max_speed = 10000
const brake_power = 10

var fluid_max_speed = 500
var speed = 0

func _physics_process(delta):
	fluid_max_speed = boost_max_speed if Input.is_action_pressed("SecretBoost") else base_max_speed
	
	var turn_dir = Input.get_axis("TurnLeft", "TurnRight")
	var acc_dir = Input.get_axis("Accelerate", "Reverse")
	if acc_dir:
		if abs(speed) < fluid_max_speed:
			speed += acc * acc_dir
		rotation += turn_dir * turn_speed
	else:
		speed = move_toward(speed, 0, brake_power)
	
	velocity = speed * transform.x	
	
	move_and_slide()
	


func die():
	print("Player has died.")
	get_tree().change_scene_to_file("res://UI/main_menu.tscn")
