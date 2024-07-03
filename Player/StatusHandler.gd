extends Node
class_name StatusHandler

@onready var state_machine: StateMachinePlayer = $"../StateMachine" 

const POISON := &"Poison"
const BURN := &"Burn"

const POISON_DMG: int = 5
const BURN_DMG: int = 5
var burn_curr_dmg: int = BURN_DMG

const POISON_DUR: int = 5
const BURN_DUR: int = 5
var poison_stack: int = 0: set = poison
var burn_stack: int = 0: set = burn

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	owner.take_damage.connect(_take_damage)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _take_damage(dmg: Damage):
	for status: StringName in dmg.statuses:
		match status:
			POISON:
				poison_stack += 1
			BURN:
				burn_stack += 1
			_:
				pass


func poison(val: int) -> void:
	poison_stack = val
	$Poison/Duration.start(POISON_DUR**poison_stack)
	$Poison/Timer.start()


func burn(val: int) -> void:
	burn_stack = val
	$Burn/Duration.start(BURN_DUR)
	$Burn/Timer.start()
	burn_curr_dmg = BURN_DMG**burn_stack
	

func reset_poison_params() -> void:
	poison_stack = 0
	$Poison/Timer.stop()
	
func reset_burn_params() -> void:
	burn_curr_dmg = BURN_DMG
	burn_stack = 0
	$Burn/Timer.stop()

func _on_poison() -> void:
	%Health.hp -= POISON_DMG

func _on_burn() -> void:
	%Health.hp -= burn_curr_dmg
