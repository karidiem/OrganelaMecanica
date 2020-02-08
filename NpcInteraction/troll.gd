extends KinematicBody2D

var path = null
enum {
	WALKING,
	TALKING
}
const MOTION_SPEED = 150 # Pixels/second
var state: int = WALKING 
onready var json_controller = get_parent()

func cartesian_to_isometric(cartesian):
	var screen_pos = Vector2()
	screen_pos.x = cartesian.x - cartesian.y
	screen_pos.y = (cartesian.x + cartesian.y) / 2
	return screen_pos
	
func _physics_process(_delta):
	var motion = Vector2()
	match state:
		WALKING:
			
			if(path != null && Input.is_action_pressed("ui_accept")):
				state = TALKING
			if Input.is_action_pressed("move_up"):
				motion += Vector2(0, -1)
			if Input.is_action_pressed("move_bottom"):
				motion += Vector2(0, 1)
			if Input.is_action_pressed("move_left"):
				motion += Vector2(-1, 0)
			if Input.is_action_pressed("move_right"):
				motion += Vector2(1, 0)
				
			motion = motion.normalized() * MOTION_SPEED * _delta 
			motion = cartesian_to_isometric(motion)
			move_and_collide(motion)
			pass
		TALKING:
	
			json_controller.load_json(path)
#			print(json_controller.is_in_keyword("strength"))
			var array_temp = [""]
			print(json_controller.similars(0,array_temp))
#			json_controller.is_in_keyword("strength")
			pass
	
	
	

