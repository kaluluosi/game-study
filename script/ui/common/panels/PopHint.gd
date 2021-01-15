extends BaseView
class_name PopHint

var _bb_code:String
var _stay_time_sec:float

var _rich_text_label:RichTextLabelEx
var _animation_player:AnimationPlayer

var _last_pophint:PopHint setget _set_last_pophint, _get_last_pophint

func _init(bb_code:String, stay_time_sec:float=1):
	UIName = "common/panels/PopHint.tscn"
	layer = UiManager.Layers.popup
	_bb_code = bb_code
	_stay_time_sec = stay_time_sec

func _get_last_pophint() -> PopHint:
	if 'last_pophint' in UiManager.global_value:
		return UiManager.global_value['last_pophint']
	else:
		return null

func _set_last_pophint(pophint:PopHint):
	UiManager.global_value['last_pophint'] = pophint
	
func _ready():
	_rich_text_label = ui.get_node("RichTextLabel") as RichTextLabelEx
	_animation_player = ui.get_node("AnimationPlayer") as AnimationPlayer
	
	_rich_text_label.set_bbcode(_bb_code)
	
func _on_show():
	if self._last_pophint:
		self._last_pophint.close()
	self._last_pophint = self
	
	_animation_player.play('FadeIn')
	yield(_animation_player,"animation_finished")
	yield(UiManager.get_tree().create_timer(_stay_time_sec),"timeout")
	if ui:
		# ui可能会被别的pophint顶掉而关闭，yield回来的时候已经为空
		close()

func close():
	if ui:
		_animation_player.play('FadeOutUp')
		yield(_animation_player,"animation_finished")
		.close()
