extends Node2D

const void_seg_len = 1000

@onready var global = $/root/Global
var void_seg = preload("res://Void/void_segment.tscn")

func _ready():
	var earth_circ = 2*PI*global.initial_earth_radius
	var segs = floor(earth_circ / void_seg_len)
	var current_seg_angle = 0
	var seg_angle_change = 2*PI/segs
	for i in range(segs):
		var seg = void_seg.instantiate()
		add_child(seg)
		seg.name = "VoidSegment" + str(i)
		seg.global_position = global.initial_earth_radius * Vector2.from_angle(current_seg_angle)
		print("Angle at center: " + str(current_seg_angle))
		print("Angle to pt: " + str(seg.global_position.angle_to_point(Vector2.ZERO)))
		seg.rotation = current_seg_angle
		seg.velocity = global.initial_earth_radius / global.shrink_time_secs * -Vector2.from_angle(current_seg_angle)
		current_seg_angle += seg_angle_change
