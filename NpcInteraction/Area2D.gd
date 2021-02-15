extends Area2D


func _ready():
	connect("area_entered",self,"_on_body_enter")
	connect("area_exited",self,"_on_body_exit")
func _on_body_enter(body):
	
	if body.get_parent().is_in_group("player"):
		body.get_parent().path = "janitor.json"
func _on_body_exit(body):
	
	if body.get_parent().is_in_group("player"):
		body.get_parent().path = null
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
