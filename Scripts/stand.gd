extends Node2D

#I heard you killed some slimes good for you
#Sadly i'm don't have anything to sell you the bastards took everything
#Why are you looking at me ? dont you have something to do?



@onready var label:Label = $Label


func _on_area_2d_body_entered(body):
	print("body: "+ str(body.name))
	if body.is_in_group("player"):
		label.visible = true
func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		label.visible = false
