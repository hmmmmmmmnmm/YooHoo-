extends Node

class_name TurnQueue
signal next
var active_character


func _ready():
	active_character = get_child(0)
	turns()
	
func turns():
	while true:
		print(active_character)
		if active_character == get_child(0):
			get_node("Player").player_turn = true
		yield(active_character,"complete")
		yield(get_tree().create_timer(0.05), "timeout")
		var new_index : int = (active_character.get_index() + 1) % get_child_count()
		active_character = get_child(new_index)
		emit_signal("next")
