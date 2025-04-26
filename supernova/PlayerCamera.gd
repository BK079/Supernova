extends Camera2D

@export var zoomaccel  = 1
var relativezoom : float
var zoommin = 10
var zoommax = 0.3
var zoom_target  = 1.0
var zoom_current = 1.0



func _ready():
	pass

func _process(delta):
	Zoom(delta)


func Zoom(delta):
	if Input.is_action_just_pressed("Scrollin"):
		zoom_target = zoom_current * 1.5
	if Input.is_action_just_pressed("Scrollout"):
		zoom_target = zoom_current * 0.5
	zoom_current = clamp(lerp(zoom_current, zoom_target, 1*delta), zoommax, zoommin)
	self.zoom = (Vector2(zoom_current, zoom_current))
