extends Area2D
class_name Hurt

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal make_damage(from, damage)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func make_damage(from, damage):
	emit_signal("make_damage", from, damage)
