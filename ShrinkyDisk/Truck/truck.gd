extends CharacterBody2D

var rng = RandomNumberGenerator.new()

@onready var global = $/root/Global
@onready var anim = $AnimationPlayer

enum TRUCK_STATE {
	STRAIGHT,
	DONUTS
}

func _ready():
	# Teleport close to an edge of the Earth
	anim.play("Drive")
	global_position = .8 * global.initial_earth_radius *  Vector2.from_angle(rng.randf_range(-PI, PI))
	drive_dir = rng.randf_range(-PI, PI)

const acc = 2
const turn_speed = .1
const max_speed = 600
const change_dir_cooldown = .5

var speed = 0
var drive_dir = 0
var drive_state = TRUCK_STATE.STRAIGHT
var can_change_dir = true

func _physics_process(delta):
	speed = speed + acc if abs(speed) < max_speed else speed
	rotation = move_toward(rotation, drive_dir, turn_speed)
	velocity = speed * transform.x
	
	if drive_state == TRUCK_STATE.DONUTS:
		drive_dir += turn_speed
	
	move_and_slide()

func change_direction():
	# Stop truck from changing dir until it has left the void
	can_change_dir = false
	# Look towards the center of the Earth plus a random num up to ±PI/4 radians
	drive_dir = (-global_position).angle() + rng.randf_range(-PI/4, PI/4)
	if abs(drive_dir) > 2*PI:
		drive_dir -= (drive_dir/abs(drive_dir))*2*PI
	# Wait for cooldown to end before being able to change dirs again
	await get_tree().create_timer(change_dir_cooldown).timeout
	can_change_dir = true

func _on_hurtbox_body_entered(body):
	if "VoidSegment" in body.name and can_change_dir:
		change_direction()

