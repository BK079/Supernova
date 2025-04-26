extends Node2D

var Starcount = randi_range(1, 3)
var Planetcount = randi_range(1, 12)
var orbits : Array

@export var Star = load("res://OtherStar.tscn")
@export var Planet = load("res://Planet.tscn")


	
	
func _ready():
	for i in Planetcount:
		var Planetinstance = Planet.instantiate()
		get_child(0).add_child(Planetinstance)
		var orbitradius = randi_range(100.0, 3000.0)
		while orbits.any(func(number): return ((orbitradius - 100) <= number and number <= (orbitradius + 100))):
			orbitradius = randi_range(100.0, 3000.0)
		orbits.append(orbitradius)
		get_child(0).get_child(i+2).orbitradius = orbitradius
		get_child(0).get_child(i+2).position = Vector2(orbitradius, orbitradius).rotated(randf_range(-2*PI, 2*PI))
		
	
