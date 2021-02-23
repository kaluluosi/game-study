extends StateMachine

# 技能触发条件
var trigger_action:String = "skill_01"

var ability:AbilityAction

func enter(target):
	pass
	
	#ability = target.get_ability_state()
	#add_state(ability)
	#start.add_translation(ability.name)
	#ability.add_translation('end')
	
	
func exit(target):
	pass
	#remove_state(ability)

