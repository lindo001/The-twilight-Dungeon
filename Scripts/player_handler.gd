extends CharacterBody2D

@export var moveSpeed:int = 100
var direction
#State enum{}
@onready var sprite = $AnimatedSprite2D
@onready var hit_box = $HitBox/CollisionShape2D
var isAttacking =false
@export var HP:int = 100
@onready var progress_bar = $ProgressBar
@onready var restart_game = $restart_game
var one_shot = false
func _ready():
	progress_bar.value = HP

func _physics_process(delta):
	if HP<1:
		if one_shot==false:
			one_shot = true
			restart_game.start()
		print(restart_game.time_left)
		#queue_free()
	if !isAttacking:
		velocity = input_handler()
	if Input.is_action_just_pressed("attack_a"):
		hit_box.disabled = false
		print("A01")
		velocity = Vector2.ZERO
		if Input.is_action_pressed("right"):
			sprite.flip_h = false
			sprite.play("attack_right")
		elif Input.is_action_pressed("left"):
			sprite.flip_h = true
			sprite.play("attack_right")
		elif Input.is_action_pressed("up"):
			sprite.play("attack_up")
		elif Input.is_action_pressed("down"):
			sprite.play("attack_down")
			print("A03")
		
		isAttacking=true
	move_and_slide()

func input_handler():
	direction = Input.get_vector("left","right","up","down")

	if direction.x>0:
		sprite.flip_h = false
		sprite.play("walk_right")
	elif direction.x<0:
		sprite.flip_h = true
		sprite.play("walk_right")

	elif direction.y>0:
		sprite.play("walk_down")
	elif  direction.y<0:
		sprite.play("walk_up")
	else:
		sprite.play("Idle_down")
	
	return direction*moveSpeed
	


func _on_animated_sprite_2d_animation_finished():
	
	if sprite.animation =="attack_up" ||sprite.animation =="attack_down"||sprite.animation =="attack_right":
		print("A04")
		print(isAttacking)
		isAttacking=false
		print(isAttacking)

		hit_box.disabled = true

func decreseHP(val):
	HP-=val
	progress_bar.value = HP
func _on_hurt_box_area_entered(area):
	
	if area.is_in_group("enemy"):
		if area.name == "stings":
			HP-=8
		else:
			HP-=4
		progress_bar.value = HP


func _on_restart_game_timeout():
	Transition.change_scene("res://Scene/world.tscn")
