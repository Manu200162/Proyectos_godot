extends KinematicBody2D

export(int) var w_range = 50


var speed = 200
var accel = 2
var velocity = Vector2.ZERO
var hp = 5
var hurt = false
var die = false
onready var state_machine = $AnimationTree.get("parameters/playback")

onready var start_position = global_position
onready var target_position = global_position


signal attacking_player(area)


func _physics_process(delta):
	if hurt:
		state_machine.travel("attack")
		hurt = false
	
	if die:
		state_machine.travel("dead")
		velocity = Vector2.ZERO
		#hurt = false
	
	

func _on_HitBox_area_entered(area):
	if ! die:
		state_machine.travel("attack")
		emit_signal("attacking_player",area)


func _on_Player_attacking_enemy(area):
	if ! die:
		hurt = true
		hp -= 1
		print(hp)
		if hp <= 0:
			die = true
		print(area)
		



