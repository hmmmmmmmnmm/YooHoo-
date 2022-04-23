extends ProgressBar



func _ready():
	pass 




func _on_enemy_stats_damage_taken():
	self.value = get_parent().get_node("enemy_stats").hp
