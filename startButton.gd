extends Button
var score_file = "user://sledhighscore.txt"
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	get_tree().change_scene("res://level.tscn")



func _on_credits_pressed():
	get_tree().change_scene("res://credits.tscn")
func _on_board_pressed():
	get_tree().change_scene("res://leaderboard.tscn")


func _on_settings_pressed():
	get_tree().change_scene("res://settings.tscn")



func _on_backtomenu_pressed():
	get_tree().change_scene("res://mainmenu.tscn")



func _on_clearscore_pressed():
     var f = File.new()
     f.open(score_file, File.WRITE)
     f.store_string(str(0))
     f.close()
     var labels = get_node('/root/Node2D/Label')
     labels.set_text(str(0))

