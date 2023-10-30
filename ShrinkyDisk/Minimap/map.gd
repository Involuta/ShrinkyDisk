extends Control

@onready var global = $/root/Global

@onready var minivan_icon = $MIMarginContainer
@onready var truck_icon = $TIMarginContainer
@onready var van_icon = $VIMarginContainer

@onready var minivan = $/root/DriveLevel/Minivan
@onready var truck = $/root/DriveLevel/Truck
@onready var van = $/root/DriveLevel/Van

# global_position is the position of the parent map object
@onready var shrinking_earth = $SEMarginContainer
var initial_map_radius = 450
@onready var map_center = shrinking_earth.get_position() + Vector2.ONE * initial_map_radius

func _ready():
	shrinking_earth.set_size(Vector2.ONE * initial_map_radius*2)
	shrinking_earth.set_position(map_center - Vector2.ONE * initial_map_radius)
	set_visible(false)
	request_ready()
	shrinking_earth.request_ready()

func _process(delta):
	if Input.is_action_just_pressed("OpenMap"):
		# Set map size
		var current_map_radius = initial_map_radius * (global.shrink_time_remaining_secs / global.shrink_time_secs)
		shrinking_earth.set_size(Vector2.ONE * current_map_radius*2)
		# Move map; its position is its top-left corner
		shrinking_earth.set_position(map_center - Vector2.ONE * current_map_radius)
		
		# Scale vehicles' global positions to initial map size
		minivan_icon.set_position(map_center + initial_map_radius*(minivan.global_position / global.initial_earth_radius))
		truck_icon.set_position(map_center + initial_map_radius*(truck.global_position / global.initial_earth_radius))
		van_icon.set_position(map_center + initial_map_radius*(van.global_position / global.initial_earth_radius))
		set_visible(!visible)

func _exit_tree():
	shrinking_earth.set_size(Vector2.ONE * initial_map_radius*2)
	shrinking_earth.set_position(map_center - Vector2.ONE * initial_map_radius)
	set_visible(false)
