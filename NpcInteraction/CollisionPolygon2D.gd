extends CollisionPolygon2D



func _ready():
	connect("area_entered",self,"_on_body_enter")
	
func _on_body_enter(body):
#	get_parent().set_scala(1*delta_public)
	
	print("BUCETAO")
	if body.is_in_group("player"):
		print("BUCETAO")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
