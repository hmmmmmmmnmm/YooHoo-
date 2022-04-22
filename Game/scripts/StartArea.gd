extends TileMap

signal change_room

func _ready():
	self.connect("change_room",self.get_parent(),"_on_change_room")



func _on_Area2D_area_entered(area):
	if area.name == "Player":
		self.get_parent().enemy_check()
		if self.get_parent().enemies == false :
			emit_signal("change_room")
			self.disconnect("change_room",self.get_parent(),"_on_change_room")


