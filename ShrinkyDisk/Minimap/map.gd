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
var map_radius = 450
@onready var map_center = shrinking_earth.get_position() + Vector2.ONE * map_radius

func _ready():
	set_visible(false)

func _process(delta):
	if Input.is_action_just_pressed("OpenMap"):
		# Scale vehicles' global positions to map size
		minivan_icon.set_position(map_center + map_radius*(minivan.global_position / global.initial_earth_radius))
		truck_icon.set_position(map_center + map_radius*(truck.global_position / global.initial_earth_radius))
		van_icon.set_position(map_center + map_radius*(van.global_position / global.initial_earth_radius))
		set_visible(!visible)
