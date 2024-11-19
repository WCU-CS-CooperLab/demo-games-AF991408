extends CanvasLayer

func update_score(value):
	$MarginContainer/Score.text = str(value)
	
func update_timer(value):
	$Time.text =str(value)
	
func update_level(value):
	$MarginContainer/Level.text = str(value)
	
func update_key(value):
	$keynum.text = str(value)
	
func show_message(text):
	$Message.text = text
	$Message.show()
	$Timer.start()





func _on_timer_timeout():
	$Message.hide()
