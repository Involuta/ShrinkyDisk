extends CharacterBody2D

const acc = 5
const turn_speed = .05
const base_max_speed = 500
const boost_max_speed = 10000
const brake_power = 10

var invincible = true
var fluid_max_speed = 500
var speed = 0

@onready var anim = $AnimationPlayer

func _ready():
	anim.play("Drive")
	await get_tree().create_timer(1).timeout
	invincible = false

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
	get_tree().change_scene_to_file("res://UI/main_menu.tscn")


func _on_hurtbox_body_entered(body):
	if "Truck" in body.name:
		print("You win!")
		await get_tree().create_timer(1).timeout
		die()
	if "VoidSegment" in body.name and !invincible:
		set_physics_process(false)
		anim.play("Fall")
		await get_tree().create_timer(1).timeout
		die()
