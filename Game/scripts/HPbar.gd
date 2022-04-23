extends ProgressBar



func _ready():
	pass 


func _on_stats_damage_taken():
	self.value = get_parent().get_node("stats").hp
