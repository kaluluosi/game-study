tool
extends EditorPlugin

var ladder:Ladder
var dragging:bool

func is_valid():
	if !Engine.editor_hint:
		return false
		
	if ladder == null:
		return false
	return is_instance_valid(ladder)

func get_gt():
	var g_t = get_editor_interface().get_edited_scene_root().get_viewport().global_canvas_transform
	return g_t

func handles(object):
	return object is Ladder

func edit(object):
	ladder = object

func get_handle_pos():
	var t = get_gt()*ladder.get_global_transform()
	var pos = t.xform(ladder.handle_position)
	return pos

func set_handle_pos(vector):
	if !is_valid():
		return
	var t = get_gt()*ladder.get_global_transform()
	var pos = t.affine_inverse().xform(vector)
	ladder.handle_position = Vector2(ladder.handle_position.x, pos.y)

func draw_handle(overlay):
	if !is_valid():
		return
	var pos = get_handle_pos()
	overlay.draw_circle(pos, 6, Color.white)
	overlay.draw_circle(pos, 4, Color.pink)

func click_handle(pos):
	return (pos - get_handle_pos()).length() <= 6

func forward_canvas_draw_over_viewport(overlay):
	if !is_valid():
		return 
	draw_handle(overlay)
	ladder.update()

func forward_canvas_gui_input(event):

	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed and !dragging:
				dragging = click_handle(event.position)
				return dragging
			else:
				dragging = false

	if event is InputEventMouseMotion and dragging:
		set_handle_pos(event.position)
		update_overlays()
		return false
	return false
