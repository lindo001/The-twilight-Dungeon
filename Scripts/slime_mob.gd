extends CharacterBody2D

enum STATE { CHASE, IDLE, MOVE }

@export var moveSpeed: int = 20
@export var HP: int = 20
var current_state: STATE = STATE.IDLE
@export var target:CharacterBody2D
@onready var timer: Timer = $Timer
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _physics_process(delta):
	if HP < 1:
		sprite.play("death")
		collision_shape_2d.disabled = true
		queue_free() 

	if current_state == STATE.CHASE:
		if target:
			position += (target.position - position).normalized() * moveSpeed * delta
		sprite.play("walk")
	else:
		sprite.play("idle")

func _on_sight_body_entered(body):
	if body.is_in_group("player"):
		current_state = STATE.CHASE

func _on_sight_body_exited(body):
	if body.is_in_group("player"):
		current_state = STATE.IDLE
		timer.start()

func _on_timer_timeout():
	current_state = STATE.MOVE

func _on_hurt_box_area_entered(area):
	if area.is_in_group("player_weapon"):
		HP -= 5

func _on_animated_sprite_2d_animation_finished():
	if sprite.animation == "death":
		queue_free()  
