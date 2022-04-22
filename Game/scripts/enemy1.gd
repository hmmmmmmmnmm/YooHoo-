extends KinematicBody2D

signal complete

var tile_size = 32
var player_position = null
var direct_line = null
var attack = false
var moving = true
var aggro = false
var rng = RandomNumberGenerator.new()
onready var damage = get_child(5).enemy1_damage

func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2
	yield(self,"tree_entered")
	rng.randomize()
	while true:
		yield(get_node("/root/Node2D/TurnQueue"),"next")
		if get_parent().active_character == self:
			yield(get_tree().create_timer(0.01), "timeout")
			if moving == true:
				move()
			if attack == true:
				damage = get_child(5).enemy1_damage
				attack_player(damage)
				print("floppa attacks")
			emit_signal("complete")
			
onready var ray = $RayCast2D

func move():
	var random_number = rng.randf_range(0.0,100.0)
	direct_line = (get_parent().get_node("Player").position - self.position).normalized()
	if abs(direct_line.x) > abs(direct_line.y) :
		player_position = Vector2(direct_line.x,0).normalized()
	if abs(direct_line.y) > abs(direct_line.x) :
		player_position = Vector2(0,direct_line.y).normalized()
	if abs(direct_line.y) == abs(direct_line.x) :
		if random_number > 50 :
			player_position = Vector2(direct_line.x,0).normalized()
		if random_number < 50 :
			player_position = Vector2(0,direct_line.y).normalized()
	ray.cast_to = player_position.snapped(Vector2.ONE) * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding():
		position += player_position * tile_size

func attack_player(damage_amount):
	get_parent().get_child(0).get_child(3).take_damage(damage_amount)
	
func death():
	if get_parent().active_character == self :
		emit_signal("complete")

func _on_attack_detect_area_entered(area):
	if area.name == "Player":
		attack = true
		moving = false


func _on_attack_detect_area_exited(area):
	if area.name == "Player":
		attack = false
		moving = true




func _on_aggro_area_entered(area):
	if aggro == false:
		if area.name == "Player":
			get_parent().call_deferred("remove_child", self)
			get_node("/root/Node2D/TurnQueue").call_deferred("add_child",self)
			aggro = true
