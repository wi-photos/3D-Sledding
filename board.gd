extends Label


func _ready():
    #var HTTPRequest = get_node('/root/Node2D/HTTPRequest')

    $HTTPRequest.connect("request_completed",self,"_on_HTTPRequest_request_completed")
    $HTTPRequest.request("https://www.dreamlo.com/lb/(your public code)/quote/15")
func _on_Button_pressed():
    $HTTPRequest.request("http://www.mocky.io/v2/5185415ba171ea3a00704eed")

func _on_HTTPRequest_request_completed( result, response_code, headers, body ):
    var json = JSON.parse(body.get_string_from_utf8())
    #print(json.result)
    var leaderboard = get_node('/root/Node2D/Label')
    leaderboard.set_text(str(body.get_string_from_utf8()))
    if body.get_string_from_utf8() == "":
        leaderboard.set_text("You need to connect to the internet to view the leaderboard.")