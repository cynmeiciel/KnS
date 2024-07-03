extends CanvasLayer
class_name DebugPanel

@export var P1: Player
@export var P2: Player

@onready var p: Player = P1:
	set(val):
		p = val
		$TogglePlayer.text = "P%s" % val.p_ctr.player_index
		
func _ready() -> void:
	$TogglePlayer.text = "P1"
