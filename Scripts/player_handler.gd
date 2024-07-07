extends CharacterBody2D

@export var moveSpeed:int = 100
var direction
#State enum{}
@onready var sprite = $AnimatedSprite2D
@onready var hit_box = $HitBox/CollisionShape2D




func _physics_process(delta):
	 
	velocity = input_handler()
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
	
