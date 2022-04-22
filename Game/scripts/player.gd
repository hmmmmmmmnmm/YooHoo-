extends Area2D
signal complete
var player_turn = true
var tile_size = 32
var object = null
var raw_object = null
onready var damage = get_child(3).player_damage
var inputs = { "right" : Vector2.RIGHT, 
				'left' : Vector2.LEFT,
				'up' : Vector2.UP,
				'down' : Vector2.DOWN}
			
func _ready():
	self.set_position(Vector2(0,0))
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2
	
func play_turn():
	yield()
	player_turn = false
	emit_signal("complete")


func _unhandled_input(event):
	if player_turn == false:
		return
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)
			if ray.is_colliding():
				raw_object = ray.get_collider().to_string()
				if "enemy" in raw_object:
					object= ray.get_collider()
					attack(object)
					raw_object=null
					object=null
			play_turn().resume()

onready var ray = $RayCast2D

func move(dir):
	if player_turn == false:
		return
	ray.cast_to = inputs[dir] * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding():
		position += inputs[dir] * tile_size
		
func attack(target):
	target.get_child(5).take_damage(damage)
