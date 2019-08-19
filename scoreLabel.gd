extends Label
var score_file = "user://sledhighscore.txt"
var highscore = 0

func _ready():
    var labels = get_node('/root/Node2D/Label')
    var f = File.new()
    if f.file_exists(score_file):
        f.open(score_file, File.READ)
        var content = f.get_as_text()
        highscore = int(content)
        f.close()
    labels.set_text(str(highscore))
    pass # Replace with function body.

