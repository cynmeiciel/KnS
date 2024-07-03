extends Label

@onready var H := $"../../Stats/Mana"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	text = "%d" % H.mp
