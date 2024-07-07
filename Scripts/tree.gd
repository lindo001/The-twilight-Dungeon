extends Node2D

enum State {EMPTY,FULL}
var state:State = State.FULL
var can_collect:bool = false
@onready var timer = $Timer
@onready var sprite = $AnimatedSprite2D



func _process(delta):
	if state!= State.FULL:
		
		sprite.play("empty")
	else :
		sprite.play("full")
	if can_collect && Input.is_action_just_pressed("pick up"):
		timer.start()
		state = State.EMPTY




func _on_detect_body_entered(body):
	if body.is_in_group("player"):
		can_collect = true
		


func _on_detect_body_exited(body):
	if body.is_in_group("player"):
		can_collect = false


func _on_timer_timeout():
	print("s")
	if state == State.EMPTY:
		print("sssss")
		state = State.FULL
