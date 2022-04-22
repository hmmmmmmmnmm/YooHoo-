extends TileMap

signal change_level

func _ready():
	self.connect("change_level",self.get_parent(),"_on_change_level")



func _on_Area2D_area_entered(area):
	if area.name == "Player":
		self.get_parent().enemy_check()
		if self.get_parent().enemies == false :
			emit_signal("change_level")
			self.disconnect("change_level",self.get_parent(),"_on_change_level")
