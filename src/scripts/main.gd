extends Node

@export var pebble : PackedScene

func _ready():
	$Label.hide()
	Signals.gameover.connect(gameover)

func _on_timer_timeout():
	var pebble = pebble.instantiate()
	pebble.spawn($RockPath/RockSpawn)
	add_child(pebble)

func gameover():
	get_tree().paused = true
	$Label.show()
	await get_tree().create_timer(4.0).timeout
	get_tree().quit()
	
