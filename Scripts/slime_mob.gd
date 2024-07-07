extends CharacterBody2D

enum STATE {CHASE,IDLE,MOVE}
@export var moveSpeed:int =200
@export var HP:int =20
var current_state:STATE = STATE.IDLE
@onready var timer = $Timer
@export var target:CharacterBody2D
@onready var sprite = $AnimatedSprite2D




func _physics_process(delta):
	if HP<1:
		Erase()
	if current_state ==STATE.CHASE:
		position += (target.position - position)/moveSpeed
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


func Erase():
	
	queue_free()
func _on_timer_timeout():
	current_state = STATE.MOVE


func _on_hurt_box_area_entered(area):
	if area.is_in_group("player_weapon"):
		print("ouch")
