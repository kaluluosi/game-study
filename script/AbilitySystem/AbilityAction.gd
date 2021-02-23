extends State
class_name AbilityAction

var animation_name:String
var animation_speed:float = 1
var effect_name:String
var time = -1

var effect

var animation_player:AnimationPlayer

func enter(target:Node2D):
	animation_player = target.get_node("AnimationPlayer") as AnimationPlayer
	animation_player.play(animation_name, -1, animation_speed)
	if time == -1:
		yield(animation_player, "animation_finished")
	else:
		yield(target.get_tree().create_timer(time), "timeout")
	
	finished = true
