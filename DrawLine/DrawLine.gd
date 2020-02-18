extends Node2D
var rng = RandomNumberGenerator.new()
var color = Color(1.0, 0.0, 0.0)
var aRed = 360
var aBlu = 360
var nb_points = 2
var testicle_size = 50
func _physics_process(delta):
	
	if Input.is_action_pressed("ui_page_up"):
		nb_points += 5*delta


	if Input.is_action_pressed("ui_page_down"):
		nb_points -= 5*delta
	

	if Input.is_action_pressed("ui_up"):
		pass

	if Input.is_action_pressed("ui_down"):
		pass
	
	if Input.is_action_just_pressed("ui_home"):
		_randomize_balls()
	
	if nb_points<1.0 :
		nb_points = 1.0
	
	update()
	aBlu += 100*delta
	aRed -= 100*delta
#	if !a:
#		a = wrapf(a, 0, 360)
#	color += Color(rng.randf_range(0,1),rng.randf_range(0,1),rng.randf_range(0,1))
# Called when the node enters the scene tree for the first time.

func _randomize_balls():
	nb_points = rng.randf_range(3,150)
	aRed = rng.randf_range(736,8725)
	aBlu = rng.randf_range(736,8725)
	testicle_size = rng.randf_range(1, 90)

func _draw():
	
	draw_circle_arc_poly(Vector2(600,500), 100, 0, 360, Color.black) #Black Balls
	draw_circle_arc_poly(Vector2(350,500), 100, 0, 360, Color.black)
	
	draw_circle_arc_poly(Vector2(600,500), testicle_size, 0, 360, Color.gray) #White Testicles
	draw_circle_arc_poly(Vector2(350,500), testicle_size, 0, 360, Color.gray)
	
	draw_circle_arc( (Vector2(350,500)),100, aBlu, 360, Color(0,1.0,1.0) )
	draw_circle_arc( (Vector2(350,500)),100, aRed, 360, color )

	draw_circle_arc( (Vector2(600,500)),100,aBlu,360,Color(0,1.0,1.0) )
	draw_circle_arc( (Vector2(600,500)),100,aRed,360,color )

#	loop de espiral de triangulos A.K.A. Cu
#	var tri_c=nb_points*1.0
#	for i in tri_c:
#		draw_eq_triangle( (Vector2(500, 300)),30+i,aBlu/100+i,5,Color(1.0-i/tri_c,0-i/tri_c,1.0-i/tri_c))
	
func draw_eq_triangle(xy, length, angle,stroke, color):
	xy = Vector2(xy.x-length/2,xy.y)
	var x = xy
	var y = Vector2(xy.x+length,xy.y)
	var z = Vector2(xy.x+length/2 , xy.y-length )
#	
	x = rotate_matrix(angle,Vector2(0,0))
	y = rotate_matrix(angle,Vector2(y.x-xy.x,y.y-xy.y))
	z = rotate_matrix(angle,Vector2(z.x-xy.x,z.y-xy.y))

	draw_line(Vector2(x.x+xy.x,x.y+xy.y), Vector2(y.x+xy.x,y.y+xy.y), color, stroke,false)
	draw_line(Vector2(y.x+xy.x,y.y+xy.y), Vector2(z.x+xy.x,z.y+xy.y), color, stroke,false)
	draw_line(Vector2(z.x+xy.x,z.y+xy.y), Vector2(x.x+xy.x,x.y+xy.y), color, stroke,false)



#	x = rotate_matrix(angle,Vector2(xy.x-490,xy.y-300))
#	y = rotate_matrix(angle,Vector2(y.x-490,y.y-300))
#	z = rotate_matrix(angle,Vector2(z.x-490,z.y-300))
#
#	draw_line(Vector2(x.x+490,x.y+300), Vector2(y.x+490,y.y+300), color, stroke,false)
#	draw_line(Vector2(y.x+490,y.y+300), Vector2(z.x+490,z.y+300), color, stroke,false)
#	draw_line(Vector2(z.x+490,z.y+300), Vector2(x.x+490,x.y+300), color, stroke,false)
# rotation on  0,0 pivot:
#	y = rotate_matrix(nb_points,y)
#	z = rotate_matrix(nb_points,z)
##	x = rotate_matrix(nb_points,x)
#	draw_line(x, y, color, 10)
#	draw_line(y, z, color, 1)
#	draw_line(z, x, color, 1)

func rotate_matrix(rot,vet):
#	multiply |x| by |cos(b)-sin(b)|
#            |y|    |sin(b)+cos(b)|
	var result = Vector2(  cos(rot)*vet.x -sin(rot)*vet.y, sin(rot)*vet.x + cos(rot)*vet.y)
#	var result = rot.x * vet_x + rot.y * vet_y
	return result
	
	
func draw_circle_arc_poly(center, radius, angle_from, angle_to, color):
	var nb_points = 32
	var points_arc = PoolVector2Array()
	points_arc.push_back(center)
	var colors = PoolColorArray([color])

	for i in range(nb_points + 1):
		var angle_point = deg2rad(angle_from + i * (angle_to - angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
	draw_polygon(points_arc, colors)
	

func draw_circle_arc(center, radius, angle_from, angle_to, color):

	var points_arc = PoolVector2Array()
	for i in range(nb_points + 1):
		var angle_point = deg2rad(angle_from + i * (angle_to-angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)

	for index_point in range(nb_points):
		draw_line(points_arc[index_point], points_arc[index_point + 1], color)
