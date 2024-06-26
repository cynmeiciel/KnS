extends Camera2D

# Standard Zoom: Actually the width of the window (rendering)
var STD_Z: float
const MIN_ZOOM_DIST = 500


func get_new_pos() -> Vector2:
	return (%Player1.position + %Player2.position) / 2

# Get the fancy zoom so that both players can have their spots
func get_new_zoom() -> Vector2:
	var _zoom: float
	var p_dist_vec: Vector2 = (%Player1.position - %Player2.position)
	
	_zoom = clampf(STD_Z/abs(p_dist_vec.x), STD_Z/owner.WIDTH, STD_Z/MIN_ZOOM_DIST)
	
	return Vector2(_zoom, _zoom)

# Called when the node enters the scene tree for the first time.
func _ready():
	limit_bottom = 300
	await owner.ready
	limit_top = -owner.HEIGHT
	limit_left = -owner.WIDTH/2 - 50
	limit_right = owner.WIDTH/2 + 50


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	STD_Z = RenderingServer.get_rendering_device().screen_get_width() - 200
	
	self.position = get_new_pos()
	self.zoom = get_new_zoom()