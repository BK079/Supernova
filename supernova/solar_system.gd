extends Node2D

var Starcount = randi_range(1, 3)
var Planetcount = randi_range(0, 20)


var Star = load("res://OtherStar.tscn")
var Planet = load("res://Planet.tscn")


func _ready():
	print(Starcount)
	for i in Starcount:
		var Starinstance = Star.instantiate()
		add_child(Starinstance)
		get_child(i).set_global_position(Vector2(10*i, 10*i))
	print(Planetcount)
	for i in Planetcount:
		var Planetinstance = Planet.instantiate()
		add_child(Planetinstance)
		get_child(i).set_global_position(Vector2(100*i, 100*i))
