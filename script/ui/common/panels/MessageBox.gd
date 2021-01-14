extends BasePanel

class_name MessageBox

enum Result {Ok, Cancel, Close}
enum Type {Ok, OkCancel}

signal result(value)

var _type

var _btn_ok:Button
var _btn_cancel:Button
var _lbl_title:Label

func _init(title:String, msg:String, type=Type.Ok):
	UIName = "common/panels/MessageBox.tscn"
	layer = UiManager.Layers.popup
	_type = type

func _ready():
	# todo: 找出UI控件引用
	_lbl_title = ui.get_node("Panel/VBoxContainer/TitleBar/lblTitle")
	_btn_cancel = ui.get_node("Panel/VBoxContainer/Buttons/HBoxContainer/BtnCancel")
	_btn_ok = ui.get_node("Panel/VBoxContainer/Buttons/HBoxContainer/BtnOk")
