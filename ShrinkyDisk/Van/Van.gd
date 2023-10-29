extends CharacterBody2D

var rng = RandomNumberGenerator.new()

@onready var global = $/root/Global
@onready var anim = $AnimationPlayer
@onready var minivan = $/root/DriveLevel/Minivan

enum VAN_STATE {
	STRAIGHT,
	CHASE
}

func _ready():
	# Teleport close to an edge of the Earth
	anim.play("Drive")
	global_position = .8 * global.initial_earth_radius *  Vector2.from_angle(rng.randf_range(-PI, PI))
	drive_dir = rng.randf_range(-PI, PI)

const acc = 2
const turn_speed = .05
const max_speed = 400
const edge_change_dir_cooldown = .5

var speed = 0
var drive_dir = 0
var drive_state = VAN_STATE.STRAIGHT
var edge_can_change_dir = true

func _physics_process(delta):
	speed = speed + acc if abs(speed) < max_speed else speed
	rotation = move_toward(rotation, drive_dir, turn_speed)
	velocity = speed * transform.x
	
	if (drive_state == VAN_STATE.CHASE) or Input.is_action_just_pressed("OpenMap"):
		drive_dir = (minivan.global_position - global_position).angle()
	
	move_and_slide()

func edge_change_direction():
	# Stop van from changing dir until it has left the void
	edge_can_change_dir = false
	# Look towards the center of the Earth plus a random num up to ±PI/4 radians
	drive_dir = (-global_position).angle() + rng.randf_range(-PI/4, PI/4)
	if abs(drive_dir) > 2*PI:
		drive_dir -= (drive_dir/abs(drive_dir))*2*PI
	# Wait for cooldown to end before being able to change dirs again
	await get_tree().create_timer(edge_change_dir_cooldown).timeout
	edge_can_change_dir = true

func _on_player_detector_body_entered(body):
	if "Minivan" in body.name:
		drive_state = VAN_STATE.CHASE

func _on_player_detector_body_exited(body):
	if "Minivan" in body.name:
		drive_state = VAN_STATE.STRAIGHT

func _on_hurtbox_body_entered(body):
	if "VoidSegment" in body.name and edge_can_change_dir:
		edge_change_direction()
