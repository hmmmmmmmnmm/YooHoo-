extends Node

signal damage_taken

var hp = 10
var enemy1_damage = 10

func take_damage(amount):
		hp = hp - amount
		emit_signal("damage_taken")
		if hp <= 0:
			get_parent().death()
			get_parent().queue_free()
			

