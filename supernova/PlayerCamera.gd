extends Camera2D

@export var zoomaccel  = 1
var relativezoom : float
var mass = 1.0

var zoom_target  = 1.0
var zoom_current = 1.0
signal zoomlvl


func _ready():
	pass

func _process(delta):
	Zoom(delta)


func Zoom(delta):
	if Input.is_action_just_pressed("Scrollin"):
		zoom_target = zoom_current * 1.8
	if Input.is_action_just_pressed("Scrollout"):
		zoom_target = zoom_current * 0.2
	var zoommax = (10/mass)
	var zoommin = mass/50
	zoom_current = clamp(lerp(zoom_current, zoom_target, 1*delta), zoommax, zoommin)
	self.zoom = (Vector2(zoom_current, zoom_current))
	$Control.scale = Vector2(1/zoom_current, 1/zoom_current)
	$Control.position.x = -926/zoom_current
	$Control.position.y = -507/zoom_current
	zoomlvl.emit(zoom_current)
