extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
#	UIUtil.debounce()
#	var msgbox = MessageBox.new('测试', 'hello 测试一下')
#	msgbox.show()
#	var ret = yield(msgbox, "done")
#	print('msg box done ', ret)
	UIUtil.pop_hint('[center]功能未开放!开放等级[color=red]15级[/color][/center]')


func _on_msgbox_pressed():
	var box = UIUtil.messagebox('测试','这是个测试文本，试一下按按钮。。。。。。。。。。。。。。。。。。。。。。。。。。', MessageBox.Type.OK_CANCEL)
	var ret = yield(box, 'done')

	match ret:
		MessageBox.Result.OK:
			UIUtil.pop_hint('[center]你按下了OK[/center]')
		MessageBox.Result.CANCEL:
			UIUtil.pop_hint('[center]你按下了CANCEL[/center]')
		var other:
			UIUtil.pop_hint('[center]你按下了%s[/center]'%other)
			
