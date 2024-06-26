extends Node2D

@onready var WIDTH: float = abs(%BoundL.position.x - %BoundR.position.x)
# Defined for each map
const HEIGHT = 600

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_key_pressed(KEY_KP_ADD):
		$Camera.zoom += Vector2.ONE/1000
	
	if Input.is_key_pressed(KEY_KP_SUBTRACT):
		$Camera.zoom -= Vector2.ONE/1000