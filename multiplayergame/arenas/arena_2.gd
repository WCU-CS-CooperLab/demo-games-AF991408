extends Node




#func _on_item_spawner_timer_timeout():
#	$BluePlayer.change_powerup_state(0) #0 = NONE
#	print('power over')

func _on_blue_player_item_pickup():
	$ItemSpawnerTimer.start()


func _on_red_player_item_pickup():
	$ItemSpawnerTimer.start()
	
