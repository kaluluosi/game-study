extends RichTextEffect
class_name _FontSizeEffect 
	
var bbcode = "size"
	
func _process_custom_fx(char_fx:CharFXTransform):
	char_fx.visible = false
	return true
