extends Camera2D

# Width n Height
var _W: float
var _H: float
const WMIN_ZOOM_DIST = 530
var HMIN_ZOOM_DIST: float
const MARGIN := 200

func get_new_pos() -> Vector2:
	return (%Player1.position + %Player2.position) / 2

# Get the fancy zoom so that both players can have their spots
func get_new_zoom() -> Vector2:
	var _zoom: float
	var p_dist_vec: Vector2 = abs(%Player1.position - %Player2.position)
	
	if p_dist_vec.x > p_dist_vec.y*(_W/_H):
		_zoom = clampf(_W/p_dist_vec.x, _W/owner.WIDTH, _W/WMIN_ZOOM_DIST)
	else:
		_zoom = clampf(_H/p_dist_vec.y, _H/owner.HEIGHT, _H/HMIN_ZOOM_DIST)

	return Vector2(_zoom, _zoom)

# Set the limits. This method should be reusable for every map/stage
func _ready():
	await owner.ready
	limit_bottom = 300
	limit_top = -owner.HEIGHT
	limit_left = -owner.WIDTH/2 - 50
	limit_right = owner.WIDTH/2 + 50

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	_W = RenderingServer.get_rendering_device().screen_get_width() - MARGIN
	_H = RenderingServer.get_rendering_device().screen_get_height() - MARGIN
	HMIN_ZOOM_DIST = WMIN_ZOOM_DIST*_H/_W
	self.position = get_new_pos()
	self.zoom = get_new_zoom()
