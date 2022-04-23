extends Node2D
var current_room = null
onready var next_room = get_child(0)
var next_pool = null
onready var player_node = get_child(1).get_child(0)
var enemies = false
var creature_list = ""
var room_number = -1
var level_number = 1
var pool_name = ''
var level_1 = preload("res://scenes/level_1.tscn")


func _ready():
	
	pass
	


func change_room():
	current_room = get_child(0)
	if next_room == current_room and enemies == false:
		room_number = room_number + 1
		pool_name = .get("level_" + str(level_number))
		next_pool = pool_name.instance().get_child(room_number)
		next_room = next_pool.get_child(0)
		next_pool.remove_child(next_room)
		yield(get_tree().create_timer(0.05), "timeout")
		next_room.visible = true
		current_room.replace_by(next_room)
		next_pool.queue_free()
		next_room.get_children()[-1].queue_free()
		current_room.queue_free()
		player_node._ready()
		current_room = null
		next_pool = null

func _on_change_room():
	change_room()
	
func _on_change_level():
	level_number = level_number + 1
	print("changed")

func enemy_check():
	creature_list = str(get_node("/root/Node2D/TurnQueue").get_children())
	creature_list = creature_list + str(.get_child(0).get_children())
	if "enemy" in creature_list :
		enemies = true
	if not "enemy" in creature_list :
		enemies = false
