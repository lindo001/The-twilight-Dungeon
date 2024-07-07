extends CharacterBody2D

enum STATE { IDLE, MOVE, PAUSE, TALKING }

var roaming: bool = true
var talking: bool = false
var moveSpeed: int = 20
var current_state: STATE = STATE.IDLE
var direction: Vector2 = Vector2.DOWN

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer
@onready var label: Label = $Label

func _physics_process(delta):
	handle_state()

	if roaming:
		match current_state:
			STATE.IDLE:
				pass
			STATE.PAUSE:
				
				direction = shuffle([Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT, Vector2.UP])
				current_state = STATE.MOVE
			STATE.MOVE:
				move(delta)
	
	move_and_slide()

func handle_state():
	if talking:
		current_state = STATE.TALKING
		sprite.play("talk")
	elif current_state == STATE.IDLE:
		sprite.play("idle")
	elif current_state == STATE.PAUSE:
		sprite.play("idle")  
	elif direction.x > 0:
		sprite.play("walk_right")
	elif direction.x < 0:
		sprite.play("walk_left")
	elif direction.y > 0:
		sprite.play("walk_down")
	elif direction.y < 0:
		sprite.play("walk_up")

func shuffle(arrayR):
	arrayR.shuffle()
	return arrayR[0]

func move(delta):
	position += direction * moveSpeed * delta

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		talking = true

func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		talking = false

func _on_timer_timeout():
	timer.wait_time = shuffle([0.2, 0.5])
	current_state = shuffle([STATE.IDLE,STATE.PAUSE ,STATE.MOVE])
