extends Area2D


var direction = Vector2.RIGHT
var moveSpeed = 200

func _process(delta):
	position +=direction *moveSpeed*delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_entered(area):
	if area.is_in_group("player_weapon"):
		queue_free()
