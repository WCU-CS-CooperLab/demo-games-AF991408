extends Node

var messages = ""

var typing_speed = 0.1
var read_time = 3

var current = 0
var display = ""
var current_char = 0

func start_dialogue():
	current = 0
	display = ""
	current_char = 0
	
	$characterTimer.set_wait_time(typing_speed)
	$characterTimer.start()

func stop_dialogue():
	queue_free()

func _on_character_timer_timeout() -> void:
	if current_char < len(messages[current]):
		var next_char = messages[current][current_char]
		display += next_char
		
		$NinePatchRect/Label.text = display
		current_char += 1
	else:
		$characterTimer.stop()
		$lineTimer.one_shot = true
		$lineTimer.set_wait_time(read_time)
		$lineTimer.start()

func _on_line_timer_timeout() -> void:
	if (current == len(messages) - 1):
		stop_dialogue()
	else:
		current += 1
		display = ""
		current_char = 0
		$characterTimer.start()

func l2Notebook():
	messages = [
	"Your first mission:",
	"Collect all of the items",
	"And you will start the 
		  quest of the bridge"
	]
	
	start_dialogue()
	return messages
