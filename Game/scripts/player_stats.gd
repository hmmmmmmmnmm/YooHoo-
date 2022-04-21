extends Node
signal death_screen

var hp = 10
var player_damage = 10

func take_damage(amount):
	hp = hp - amount
	if hp <= 0 :
		get_tree().get_root().set_disable_input(true)
		emit_signal("death_screen")
		yield(get_tree().create_timer(2), "timeout")
		get_tree().get_root().set_disable_input(false)
		get_tree().change_scene(get_tree().current_scene.filename)

