extends State
class_name AttackStateP

const ATK_STCOST: Array[int] = [6, 11]
@export var CharAtkInfo: Resource  # MP costs also stored here

var curr_atk: String = ""
var next_atk: String = "g1"
# Attack code format: <button><?button?><sequence>
# For example: g2 means the action when 'g' is performed twice

func get_atk_button(full: bool = true, atk: String = curr_atk) -> String:
	match atk.length():
		3:
			return atk[0]+atk[1] if full else atk[0]
		2:
			return atk[0]
		4:
			return "tyu"
		_:
			return "bruh?"
			

func is_next_atk_valid() -> bool:
	return true

func is_enough_cost() -> bool:
	var cost = get_cost()
	return %Mana.mp >= cost["mp"] and %Stamina.st >= cost["st"]
	
func get_cost(atk: String = curr_atk) -> Dictionary:
	match get_atk_button(false, next_atk):
		'g':
			return create_cost(ATK_STCOST[0], 0)
		'h':
			return create_cost(ATK_STCOST[1], 0)
		_:
			return create_cost(0, 0)

func create_cost(st = 0, mp = 0) -> Dictionary:
	return {"st": st, "mp": mp}

func perform_atk() -> void:
	enter()

func can_enter() -> bool:
	return is_next_atk_valid() and is_enough_cost()

func enter() -> void:
	print("Transitioned to %s" % self.name + " " + next_atk)
	p_anim.play("_a_%s" % next_atk)
	%Mana.mp -= get_cost()["mp"]
	%Stamina.st -= get_cost()["st"]

func exit() -> void:
	pass
	
func update(_delta : float) -> void:
	pass

func handle_input(_ev : InputEvent) -> void:
	if _ev.is_action_pressed(p_ctr.g):
		transits_to.emit("Attack")

func physics_update(_delta : float) -> void:
	pass


func _on_animated_sprite_2d_animation_finished():
	transits_to.emit("Idle")
