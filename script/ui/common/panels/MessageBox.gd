extends BasePanel

class_name MessageBox

enum Result {OK, CANCEL, CLOSE}
enum Type {OK, OK_CANCEL}

signal done(value)

var _type

var _btn_ok:Button
var _btn_cancel:Button
var _btn_close:Button
var _lbl_title:Label
var _edit_body:RichTextLabelEx

var _title:String setget _set_title,_get_title
var _msg:String setget _set_msg,_get_msg

func _init(title:String, msg:String, type=Type.OK):
	UIName = "common/panels/MessageBox.tscn"
	layer = UiManager.Layers.popup
	_type = type
	
	_title = title
	_msg = msg

func _ready():
	# todo: 找出UI控件引用
	_lbl_title = ui.get_node("Panel/VBoxContainer/TitleBar/lblTitle") as Label
	_btn_cancel = ui.get_node("Panel/VBoxContainer/Buttons/HBoxContainer/BtnCancel") as Button
	_btn_ok = ui.get_node("Panel/VBoxContainer/Buttons/HBoxContainer/BtnOk") as Button
	_btn_close = ui.get_node("Panel/VBoxContainer/TitleBar/BtnClose") as Button
	_edit_body = ui.get_node("Panel/VBoxContainer/Body/RichTextLabelEx") as RichTextLabelEx

	if _type == Type.OK:
		_btn_cancel.hide()
		_btn_ok.show()
	elif _type == Type.OK_CANCEL:
		_btn_cancel.show()
		_btn_ok.show()
		
	_lbl_title.text = _title
	_edit_body.set_bbcode(_msg)

	_btn_ok.connect("pressed", self, '_on_done', [Result.OK])
	_btn_cancel.connect("pressed", self, '_on_done', [Result.CANCEL])
	_btn_close.connect("pressed", self, 'close')
	
	connect("close", self, '_on_done', [Result.CLOSE])
	
func _on_done(result):
	emit_signal('done', result)
	close()
	
func _set_title(value:String):
	_title = value
	_lbl_title.text = _title

func _get_title() -> String:
	return _title
	
func _set_msg(value:String):
	_msg = _msg
	_edit_body.set_bbcode(value)

func _get_msg() -> String:
	return _msg
	
