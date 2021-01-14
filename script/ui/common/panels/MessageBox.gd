extends BasePanel

class_name MessageBox

enum Result {Ok, Cancel, Close}
enum Type {Ok, OkCancel}

signal done(value)

var _type

var _btn_ok:Button
var _btn_cancel:Button
var _btn_close:Button
var _lbl_title:Label

func _init(title:String, msg:String, type=Type.Ok):
	UIName = "common/panels/MessageBox.tscn"
	layer = UiManager.Layers.popup
	_type = type

func _ready():
	# todo: 找出UI控件引用
	_lbl_title = ui.get_node("Panel/VBoxContainer/TitleBar/lblTitle") as Label
	_btn_cancel = ui.get_node("Panel/VBoxContainer/Buttons/HBoxContainer/BtnCancel") as Button
	_btn_ok = ui.get_node("Panel/VBoxContainer/Buttons/HBoxContainer/BtnOk") as Button
	_btn_close = ui.get_node("Panel/VBoxContainer/TitleBar/BtnClose") as Button

	if _type == Type.Ok:
		_btn_cancel.hide()
		_btn_ok.show()
	elif _type == Type.OkCancel:
		_btn_cancel.show()
		_btn_ok.show()

	_btn_ok.connect("pressed", self, '_on_done', [Result.Ok])
	_btn_cancel.connect("pressed", self, '_on_done', [Result.Cancel])
	_btn_close.connect("pressed", self, 'close')
	
	connect("close", self, '_on_done', [Result.Close])
	
func _on_done(result):
	emit_signal('done', result)
	hide()
	ui.queue_free()
	
