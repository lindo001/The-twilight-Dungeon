extends Node2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var label = $Label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass





func shuffle(arrayR):
	arrayR.shuffle()
	return arrayR[0]


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		label.visible = true
		var chat = shuffle([
			"....",
			"what are you looking at"
		])
		label.text = chat


func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		label.visible = false
