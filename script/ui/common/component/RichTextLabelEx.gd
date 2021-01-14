tool 
extends RichTextLabel
class_name RichTextLabelEx

export(String, MULTILINE) var bb_code:String setget set_bbcode,get_bbcode
var _regex_flag:RegEx
const flag_pattern = "\\[font size=(?<size>\\d+)\\]|\\[/font\\]"

func _init():
	_regex_flag = RegEx.new()
	_regex_flag.compile(flag_pattern)
	var _effect = _FontSizeEffect.new()
	custom_effects.append(_effect)


func _handle_next_font_size_tag(value: String) -> String:

	var head: String
	var tail: String
	var middle:String
	
	var matches = _regex_flag.search_all(value)
	if matches and len(matches)%2==0:
		var edge_start = matches[0].get_start()
		var edge_end = matches[-1].get_end()
		head = value.substr(0, edge_start)
		tail = value.substr(edge_end, len(value)-1)
		middle = value.substr(edge_start, edge_end)
		
		var stack = []
		var index = 0
		var render_data=[]
		matches = _regex_flag.search_all(middle)
		var offset = 0
		for m in matches:
			
			var text_end = m.get_start()
			# do somthing
			if text_end > offset:
				var text = middle.substr(offset, text_end - offset)
				stack.push_front(
					{
						size=null,
						text=text,
						index=index
					}
				)
				index += 1
			
			offset = m.get_end()
			
			var size = m.get_string('size')
			if size:
				stack.push_front(int(size))
			else:
				var text_data = []
				var val = stack.pop_front()
				while typeof(val) == TYPE_DICTIONARY:
					text_data.append(val)
					val = stack.pop_front()
				var _size = val
				for data in text_data:
					data.size = _size
					render_data.append(data)
		
		render_data.sort_custom(self, '_sort_by_index')
		
		append_bbcode(head)
		
		for data in render_data:
			var new_font:DynamicFont = get("custom_fonts/normal_font")
			if new_font == null:
				append_bbcode(data.text)
			else:
				new_font = new_font.duplicate()
				new_font.size = data.size
				push_font(new_font)
				append_bbcode(data.text)
				pop()
		
		return tail
	else:
		return value

func _sort_by_index(x, y):
	return x.index < y.index


# Alas, we can't override setters AFAICT...
func set_bbcode(value: String):
	bb_code = value
	
	.clear()
	value = self._handle_next_font_size_tag(value)
#
#	# warning-ignore:return_value_discarded
	.append_bbcode(value)

func get_bbcode():
	return bb_code
	
