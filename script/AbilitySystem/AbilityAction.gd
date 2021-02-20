extends State

var animation_name:String
var effect_name:String
var time = -1

var effect

func enter():
	var animation_player = target.get_node("AnimationPlayer") as AnimationPlayer
	animation_player.play(animation_name)
	if effect_name:
		play_effect(effect_name)
	if time == -1:
		yield(animation_player, "animation_finished")
	else:
		yield(target.get_tree().create_timer(time), "timeout")
	
	finished = true
	effect.queue_free() 

func play_effect(effect_name):
	pass
