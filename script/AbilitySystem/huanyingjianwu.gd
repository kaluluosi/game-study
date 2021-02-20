extends "res://script/AbilitySystem/Ability.gd"

class Action01 extends "res://script/AbilitySystem/AbilityAction.gd":
	
	func enter():
		target.get_node("AnimationPlayer").play("attack_01")
		# PlayEffect("slash_01")
		yield(target.get_node("AnimationPlayer"), 'animation_finished')
		finished = true
