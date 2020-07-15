extends Label

func _ready():

	pass # Replace with function body.

func _process(delta):
	var t = Timer.new()
	t.set_wait_time(1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	var credits = get_node('/root/Node2D/Label')
	credits.rect_position.y += -90 * delta
	#print(credits.rect_position.y)
	var poscred = int(round(credits.rect_position.y))
	if poscred < -2292:
		get_tree().change_scene("res://mainmenu.tscn")
