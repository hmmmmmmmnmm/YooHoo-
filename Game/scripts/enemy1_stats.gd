extends Node

var hp = 5
var enemy1_damage = 10

func take_damage(amount):
		hp = hp - amount
		if hp <= 0:
			get_parent().death()
			get_parent().queue_free()
			

