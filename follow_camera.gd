extends Camera
var collision_exception = []
export var min_distance = 0.5
export var max_distance = 5.5
export var angle_v_adjust = 0.0
export var autoturn_ray_aperture = 25
export var autoturn_speed = 50
export var offset = 240
export var cycle = 0
export var cyccler = 0
var max_height = 2.0
var min_height = 0
func _physics_process(dt):
	var target = get_parent().global_transform.origin
	var poss = get_parent().global_transform.origin.x
	var label = get_node('/root/world/Label')
	var possum = int(round(poss))
	label.set_text(str(possum))
	#print(poss)
	#print(possum)
	#var offset = poss.x_axis
	#print(get_parent().get_path())
	var pos = global_transform.origin
	var up1 = Vector3(0, 0, 0)
	var up = Vector3(0, 1, 0)
	var upq = Vector3(12, 0.475,5.9450)
	var snowfall = get_node('/root/world/fall')
	#var lightt = get_node('/root/world/OmniLight')
	var snowpos = Vector3(possum + 5, 60,0)
	#var lightpos = Vector3(possum - 20, 90,0)
	snowfall.set_global_transform(Transform(up1,snowpos))
	#lightt.set_global_transform(Transform(up1,lightpos))
	var nodes1 = get_node('/root/world/Scene Root')
	var nodes2 = get_node('/root/world/Scene Root2')
	var nodes3 = get_node('/root/world/Scene Root3')
	var nodes4 = get_node('/root/world/Scene Root4')
	var nodes5 = get_node('/root/world/Scene Root5')
	var nodes6 = get_node('/root/world/Scene Root6')
	var nodes7 = get_node('/root/world/Scene Root7')
	var nodes8 = get_node('/root/world/Scene Root8')
	var nodes9 = get_node('/root/world/Scene Root9')
	#print(nodes1.get_global_transform())
	#nodes1.set_global_transform(Transform(up1,upq))
	var delta = pos - target
	#print(pos)
	if possum == offset - 180:
		#print("ready")
		var onrer = randi()%2+1
		var cycl = cycle + 1
		cycle = cycl
		var upqs = Vector3(offset, 0,5.9450)
		if cycle == 1:
			if onrer == 1:
				nodes1.set_global_transform(Transform(up1,upqs))
			else:
				if cyccler == 0:
					nodes7.set_global_transform(Transform(up1,upqs))
					cyccler = 1
				else:
					nodes1.set_global_transform(Transform(up1,upqs))
					cyccler = 0
		if cycle == 2:
			nodes2.set_global_transform(Transform(up1,upqs))
			cyccler = 0
		if cycle == 3:
			#nodes3.set_global_transform(Transform(up1,upqs))
			if onrer == 1:
				nodes3.set_global_transform(Transform(up1,upqs))
			else:
				if cyccler == 0:
					nodes8.set_global_transform(Transform(up1,upqs))
					cyccler = 1
				else:
					nodes3.set_global_transform(Transform(up1,upqs))
					cyccler = 0
		if cycle == 4:
			nodes4.set_global_transform(Transform(up1,upqs))
			#if onrer == 1:
			#	nodes4.set_global_transform(Transform(up1,upqs))
			#else:
			#	if cyccler == 0:
			#		nodes8.set_global_transform(Transform(up1,upqs))
			#		cyccler = 1
			#	else:
			#		nodes4.set_global_transform(Transform(up1,upqs))
			#		cyccler = 0
		if cycle == 5:
			nodes5.set_global_transform(Transform(up1,upqs))
			cyccler = 0
		if cycle == 6:
			if onrer == 1:
				nodes6.set_global_transform(Transform(up1,upqs))
			else:
				if cyccler == 0:
					nodes9.set_global_transform(Transform(up1,upqs))
					cyccler = 1
				else:
					nodes6.set_global_transform(Transform(up1,upqs))
					cyccler = 0
			cycle = 0
		var offe = offset
		offset = offe + 40
# somtimes the looping system bugs out.  this is a hack so if it bugs out, the level continues looping.
	if possum > offset - 80:
		#print("ready")
		var cycl = cycle + 1
		cycle = cycl
		var upqs = Vector3(offset, 0.475,5.9450)
		if cycle == 1:
			nodes1.set_global_transform(Transform(up1,upqs))
		if cycle == 2:
			nodes2.set_global_transform(Transform(up1,upqs))
		if cycle == 3:
			nodes3.set_global_transform(Transform(up1,upqs))
		if cycle == 4:
			nodes4.set_global_transform(Transform(up1,upqs))
		if cycle == 5:
			nodes5.set_global_transform(Transform(up1,upqs))
		if cycle == 6:
			nodes6.set_global_transform(Transform(up1,upqs))
			cycle = 0
		var offe = offset
		offset = offe + 40
	if delta.length() < min_distance:
		delta = delta.normalized() * min_distance
	elif delta.length() > max_distance:
		delta = delta.normalized() * max_distance
	if delta.y > max_height:
		delta.y = max_height
	if delta.y < min_height:
		delta.y = min_height
	pos = target + delta
	look_at_from_position(pos, target, up)
	var t = transform
	t.basis = Basis(t.basis[0], deg2rad(angle_v_adjust)) * t.basis
	transform = t
func _ready():
	var node = self
	while node:
		if node is RigidBody:
			collision_exception.append(node.get_rid())
			break
		else:
			node = node.get_parent()
	set_as_toplevel(true)
