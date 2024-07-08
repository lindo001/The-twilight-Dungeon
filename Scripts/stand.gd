extends Node2D

#I heard you killed some slimes good for you
#Sadly i'm don't have anything to sell you the bastards took everything
#Why are you looking at me ? dont you have something to do?



@onready var label:Label = $Label


func _on_area_2d_body_entered(body):
	print("body: "+ str(body.name))
	if body.is_in_group("player"):
		label.text = shuffle([
			"I heard you have a weapon? isnt that suspious...",
			"If I were you I wouldn't thik about heading
			 to the dungeon.Just accept that you'll be 
			traped here. Trust me.",
			"What? You want to buy something? Sorry pal.
			 Thanks to that dungeon boss I lost all by 
			items...I heard that thing eats metal...",
			"From what I heard they the previous squad has
			already cleared the minions now there's only the boss
			"
		])
		label.visible = true
func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		label.visible = false

func shuffle(arrayR):
	arrayR.shuffle()
	return arrayR[0]
