extends Node
class_name State

signal Transitioned
signal OnStateEntered(state_name)
signal OnStateExit(state_name)
#You need to run super() on Enter and Exit methods when you need to emit the signals

var name_of_state: String = ""

func Enter():
	OnStateEntered.emit(self.name)

func Exit():
	OnStateExit.emit(self.name)

func Update():
	pass

func Physics_Update(_delta:float):
	pass
