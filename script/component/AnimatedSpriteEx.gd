extends AnimatedSprite
class_name AnimatedSpriteEx
tool

var last_size:Vector2

func _ready():
	connect("frame_changed", self, '_on_frame_changed')
	centered = false

func _on_frame_changed():
	var texture = frames.get_frame(animation, frame)
	var new_size = texture.get_size()
	
	if last_size == Vector2.ZERO:
		last_size = new_size
		return
	
	if last_size != new_size:
		offset = Vector2(0, last_size.y - new_size.y)
		last_size = new_size


func play(anim:String='', backwards=false):
	var texture:Texture
	if !backwards:
		texture = frames.get_frame(anim, 0) as Texture
	else:
		var last_index = frames.get_frame_count(anim) - 1
		texture = frames.get_frame(anim, last_index) as Texture
	
	var new_size = texture.get_size()
	
	if last_size == Vector2.ZERO:
		last_size = new_size
	elif last_size != new_size:
		offset += Vector2(0, last_size.y - new_size.y)
		last_size = new_size
	.play(anim, backwards)
