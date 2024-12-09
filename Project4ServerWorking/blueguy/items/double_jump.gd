extends Area2D


func _on_body_entered(body):
	if body.is_in_group("characters"):
		if not body.has_power:
			body.change_powerup_state(body.p_state.DOUBLEJ)
			body.item_pickup.emit()
			queue_free()
	
