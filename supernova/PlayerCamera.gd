extends Camera2D

@export var zoomaccel  = 1
@export var zoommax = 0.5
@export var zoommin = 100.0
var zoom_target  = 1.0
var zoom_current = 1.0



func _ready():
	pass

func _process(delta):
	Zoom(delta)


func Zoom(delta):
	if Input.is_action_just_pressed("Scrollin"):
		zoom_target = zoom_current + zoomaccel
	if Input.is_action_just_pressed("Scrollout"):
		zoom_target = zoom_current - zoomaccel
	zoom_current = clamp(lerp(zoom_current, zoom_target, zoomaccel*delta), zoommax, zoommin)
	self.zoom = (Vector2(zoom_current, zoom_current))
