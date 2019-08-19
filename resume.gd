extends Button

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_unpause_pressed():
	get_tree().paused = false
	var pauselabel = get_node('/root/world/pauselabel')
	pauselabel.hide()


func _on_pause_pressed():
	get_tree().paused = true
	var pauselabel = get_node('/root/world/pauselabel')
	pauselabel.show()
