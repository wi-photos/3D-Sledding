
extends KinematicBody

# Member variables
var g = -9.8
var vel = Vector3()
var MAX_SPEED =25
const JUMP_SPEED = 7
const ACCEL= 2
const DEACCEL= 4
const MAX_SLOPE_ANGLE = 30
var werstarted = 0
var speeding = 0
var score_file = "user://sledhighscore.txt"
var highscore = 0
var werover = 0
var accum=0
func _physics_process(delta):
	set_process_input(true)
	accum += delta
	#print(accum)
	werstarted = 1
	var dir = Vector3() 
	var cam_xform = $target/camera.get_global_transform()
	var pauselabel = get_node('/root/world/pauselabel')
	var rightbutton = get_node('/root/world/right')
	var leftbutton = get_node('/root/world/left')
	# mobile input
	if rightbutton.is_pressed() ==true:
		dir += cam_xform.basis[0]
	if leftbutton.is_pressed() ==true:
		dir += -cam_xform.basis[0]
	# PC input
	if Input.is_action_pressed("move_left"):
		dir += -cam_xform.basis[0]
	if Input.is_action_pressed("move_right"):
		dir += cam_xform.basis[0]
	if Input.is_action_pressed("pause"):
		get_tree().paused = true
		pauselabel.show()
	dir += -cam_xform.basis[2]
	dir.y = 0
	dir = dir.normalized()
	vel.y += delta * g
	var hvel = vel
	hvel.y = 0
	var sfxpop = get_node('/root/world/wind')
	sfxpop.set_volume_db(vel.x * 0.3)
	var target = dir * MAX_SPEED
	var accel
	if dir.dot(hvel) > 0:
		accel = ACCEL
	else:
		accel = DEACCEL
	hvel = hvel.linear_interpolate(target, accel * delta)
	vel.x = hvel.x
	vel.z = hvel.z
	#print(vel.x)
	# prevents player from turning around
	var vell = vel.x
	if vel.x < 0.5:
		vel.x = 1
	if vel.x < 10.5:
		if werover == 0:
			vel.x = vell + 5
	#print(vel.x)
	
	vel = move_and_slide(vel, Vector3(0,1,0))
	
#	var hih = vel.y - 0.05
#	vel.y = hih
	# this code prevents the player from floating really far
	if is_on_floor():
		print("")
	else:
		var hih = vel.y - 0.5
		vel.y = hih
	# the longer the player has been playing, the faster it gets
	var MAX_SPEED1 = MAX_SPEED
	MAX_SPEED =MAX_SPEED1 +0.002 
	#print(MAX_SPEED)
	
	#if is_on_floor() and Input.is_action_pressed("jump"):
	#	vel.y = JUMP_SPEED


func _on_tcube_body_enter(body):
	if body == self:
		print("hi")

func load_score():
    var f = File.new()
    if f.file_exists(score_file):
        f.open(score_file, File.READ)
        var content = f.get_as_text()
        highscore = int(content)
        f.close()
func save_score():
    var labelscore = get_node('/root/world/Label')
    var inthelabel = labelscore.get_text()
    #print(inthelabel)
    var timeDict = OS.get_time();
    var dateDict= OS.get_date()
    var hour = timeDict.hour;
    var minute = timeDict.minute;
    var seconds = timeDict.second;
    #var thetime = OS.get_datetime()
    var thedate = str(dateDict.year) + str(dateDict.month) + str(dateDict.day)  
    var thetime = str(timeDict.hour) + str(timeDict.minute) + str(timeDict.second)
    var datetimefinal = thedate + thetime
    #print(accum)
    var HTTPRequest = get_node('/root/world/HTTPRequest')
    HTTPRequest.request("https://www.dreamlo.com/lb/(your super secret very long code)/add/Penguin" + datetimefinal + "/" + inthelabel + "/" + str(round(accum)))

    load_score()
    if highscore < int(inthelabel):
       var f = File.new()
       f.open(score_file, File.WRITE)
       f.store_string(str(inthelabel))
       f.close()
func _on_HTTPRequest_request_completed( result, response_code, headers, body ):
    var json = JSON.parse(body.get_string_from_utf8())
    print(json.result)
func _on_tcube_body_entered(body):
	if body == self:
		var themusic = get_node('/root/world/mainsong')
		var sled = get_node('/root/world/cubio/sled')
		var deflate = get_node('/root/world/cubio/deflate')
		sled.hide()
		deflate.show()
		var sfxpop = get_node('/root/world/cubio/pop')
		themusic.stop()
		#sfxpop.loop = false
		if werover == 0:
			sfxpop.play(0)
		werover = 1
		MAX_SPEED = 0
		vel.x = 0
		var t = Timer.new()
		t.set_wait_time(2)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		t.queue_free()
		save_score()
		set_physics_process(false)
		var golabel = get_node('/root/world/go')
		golabel.show()
		MAX_SPEED =0
		
func _on_speed_body_entered(body):
	var MAX_SPEED1 = MAX_SPEED
	speeding = 1
	if MAX_SPEED1 > 35:
		MAX_SPEED =65
	if MAX_SPEED1 < 35:
		MAX_SPEED = 45
	if MAX_SPEED1 > 65:
		MAX_SPEED = 95	
	#print(MAX_SPEED)
	var t = Timer.new()
	t.set_wait_time(1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	MAX_SPEED =MAX_SPEED1
	speeding = 0
	if werover == 1:
    	MAX_SPEED =0
	#if werover == 0:
