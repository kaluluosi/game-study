extends StaticBody2D
class_name Ladder
tool
export(Texture) var middle:Texture
export(Texture) var top:Texture
export var handle_position:Vector2 setget _set_handle_pos,_get_handle_pos

onready var trigger:CollisionShape2D
onready var platform_collision:CollisionShape2D = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	if !top or !middle:
		push_error("middle和top必须设置贴图")
	
	var shape = RectangleShape2D.new()
	trigger = CollisionShape2D.new()
	trigger.shape = shape
	$Area2D.add_child(trigger)
	
func _get_handle_pos():
	if handle_position == Vector2.ZERO:
		var size = top.get_size()
		handle_position = Vector2(0, -size.y/2)
	return handle_position 
	
func _set_handle_pos(value):
	handle_position = value
		
func get_handle_pos_global():
  return transform.xform(handle_position)

func _draw():
	var top_height = top.get_size().y
	var middle_height = middle.get_size().y
	
	var bottom = Vector2(0, top_height/2)
	var pos = Vector2(-top.get_size().x/2, -top.get_size().y/2)
	var ladder_height = (handle_position - bottom).length()
	if ladder_height - top_height <= 0:
		draw_texture(top, pos)
		set_collision_shape(1)
	else:
		var mid_count = floor((ladder_height - top_height)/middle_height)
		for i in range(mid_count):
			draw_texture(middle, pos)
			pos = Vector2(pos.x, pos.y-middle_height)
		draw_texture(top, pos)
		set_collision_shape(mid_count+1)

func set_collision_shape(count:int):
	if trigger == null:
		return
	var top_size = top.get_size()
	var mid_size = middle.get_size()
	var size = top_size
	var shape =	trigger.shape as RectangleShape2D
	
	var shape_size = Vector2(size.x/2, size.y/2*count)
	shape.extents = shape_size
	$Area2D.position = Vector2(0, -size.y/2*(count-1))

	var platform_shap = platform_collision.shape as SegmentShape2D
	platform_shap.a = Vector2(-shape_size.x,-size.y*(count-0.5))
	platform_shap.b = Vector2(shape_size.x,-size.y*(count-0.5))

func _on_Area2D_body_entered(body):
	if body is Player:
		body.climbable = true


func _on_Area2D_body_exited(body):
	if body is Player:
		body.climbable = false
