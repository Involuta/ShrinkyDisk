extends Node


var initial_earth_radius = 30000
var shrink_time_secs = 60
var shrink_time_remaining_secs = shrink_time_secs

func _process(delta):
	shrink_time_remaining_secs -= delta
