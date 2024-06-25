extends Camera2D



func get_new_pos() -> Vector2:
	return (%Player1.position + %Player2.position) / 2

func get_new_zoom() -> Vector2:
	var _zoom: float
	var p_dist_vec: Vector2 = (%Player1.position - %Player2.position)
	
	
	return Vector2(_zoom, _zoom)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position = get_new_pos()
	#self.zoom = get_new_zoom()
