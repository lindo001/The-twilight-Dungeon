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

func chat():
	
	label.visible = true
	var says = shuffle(["
	The Nest is getting stronger by
	 the day if this keeps up
	we might all die",
	"Haven't you heard? The Beasts are
	blocking our onlt exit,This is very unsual",
	"...",
	"I saw some slimes sadly, I don't
	have any weapon on me.Wait..You have one.
	GIVE IT TO ME!"
	])
	label.text = says

func handle_state():
	if talking:
		current_state = STATE.TALKING
		sprite.play("idle")
	
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
		chat()

func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		talking = false
		label.visible =false

func _on_timer_timeout():
	timer.wait_time = shuffle([0.2, 0.5])
	current_state = shuffle([STATE.IDLE,STATE.PAUSE ,STATE.MOVE])
