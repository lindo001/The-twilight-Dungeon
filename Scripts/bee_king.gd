extends  CharacterBody2D
enum STATE {IDLE,RANGED_ATTACK,DASH,FOLLOW}
var current_state:STATE= STATE.IDLE
var HP:int = 60
var moveSpeed=20
@onready var raycast = $RayCast2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@export var string:PackedScene
@onready var target = get_tree().get_nodes_in_group("player")[0] 
var  direction = Vector2.DOWN
@onready var timer = $Timer
@onready var progress_bar:ProgressBar = $ProgressBar
@onready var hurtbox = $HurtBox/CollisionShape2D


func _process(delta):
	if is_instance_valid(target):
		direction = (target.position - global_position).normalized()
		if HP>30:
			raycast.target_position = direction *900 

func _physics_process(delta):
	progress_bar.value = HP 
	if is_instance_valid(target):
		if !raycast.is_colliding():
			ranged_attck()
			
		elif raycast.is_colliding()&& HP>HP/3:
			flee(delta)
		
func ranged_attck():
	if is_instance_valid(target):
		var stringrrrr = string.instantiate()
		stringrrrr.position = global_position
		stringrrrr.direction = (target.position - global_position).normalized()
		get_tree().current_scene.call_deferred("add_child",stringrrrr)
		timer.start()

func flee(delta):
	position += (target.position - position).normalized() * moveSpeed * delta



func _on_timer_timeout():
	#if HP>30:
	timer.wait_time = 4
	#else:
		#raycast.target_position = direction *9
		#hurtbox.disabled = true
		#timer.wait_time = 0.6
		
		
	ranged_attck()


func _on_hurt_box_area_entered(area):
	if area.is_in_group("player_weapon"):
		HP -= 9
		
