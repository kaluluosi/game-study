extends KinematicBody2D

export var enable = true

var express
var action_hits

func _ready():
	pass

func _physics_process(delta):
	if enable == false:
		return
	if Input.is_action_just_pressed("ui_down"):
		
		action_hits = StateMachine.new()
		action_hits.name = "连砍"
		
		var action_01 = AbilityAction.new()
		action_01.name = "横砍"
		action_01.animation_name = "横砍"
		action_01.animation_speed = 3
		
		var action_02 = AbilityAction.new()
		action_02.name = "斜内砍"
		action_02.animation_name = "斜内砍"
		action_02.animation_speed = 3
		
		var state_machine = StateMachine.new()
		state_machine.name = "root"
		
		
		action_hits.add_state(action_01)
		action_hits.add_state(action_02)
		action_hits.start.add_translation('横砍')
		action_01.add_translation("斜内砍")
		action_02.add_translation("end")
		
		var action_final = StateMachine.new()
		action_final.name = "终结"
		
		var action_03 = AbilityAction.new()
		action_03.name = "终结"
		action_03.animation_name = "斜内砍"
		action_03.animation_speed = 0.5
		
		state_machine.add_state(action_hits)
		state_machine.start.add_translation('连砍')
		state_machine.add_state(action_03)
		action_hits.add_translation("终结", "counter >6")
		
		$StateMachinePlayer.state_machine = state_machine

		
var hit_targets = []

func _on_Hit_area_entered(area:Area2D):
	prints(area.name, area.get_groups())
	if (area in hit_targets) == false:
		hit_targets.append(area)


func _on_Hurt_make_damage(_name, damage):
	prints(name, '受到了 来自', _name, '的攻击，造成 ', name,damage)



func _on_Hit_area_exited(area):
	if area in hit_targets:
		var index = hit_targets.find(area)
		hit_targets.remove(index)

func hit():
	for area in hit_targets:
		if area.is_in_group("hurtbox"):
			# attacker = self
			# target = area
			# skill_info = state_machine.active_state
			# hit_info = {
			#  damageId = self.HitBox.meta('damageId')
			# }
			
			(area as Hurt).make_damage(name, "100")
