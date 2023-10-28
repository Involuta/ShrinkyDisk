extends Node2D

@onready var global = get_node("/root/Global")

func _ready():
	var earth_circ = 2*PI*global.initial_earth_radius

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
