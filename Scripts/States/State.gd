extends Node
class_name State

signal OnStateEntered(state_name)
signal OnStateExit(state_name)
#You need to run super() on Enter and Exit methods when you need to emit the signals

func Enter():
	OnStateEntered.emit(self.name)

func Exit():
	OnStateExit.emit(self.name)

func Update():
	pass

func Physics_Update(_delta:float):
	pass
