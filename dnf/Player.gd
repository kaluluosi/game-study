extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var enable = true

var action_1 = 		{
		damage=100,
		animation="斜内砍",
		animation_speed=5
		}
		
var action_2 = {
		damage=120,
		animation="横砍",
		animation_speed=1
	}

var skills = {
	"skill1":[
		action_1,
		action_2
	],
	"skill2":[
		action_1,
		action_1
	]
}

var current_skill
var current_action

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if enable == false:
		return
	if Input.is_action_pressed("ui_up"):
		var skill = skills.skill2
		current_skill = skill
		for action in current_skill:
			$AnimationPlayer.play(action.animation,-1, action.animation_speed)
			current_action = action
			yield($AnimationPlayer, "animation_finished")
	
	if Input.is_action_pressed("ui_down"):
		var skill = skills.skill1
		current_skill = skill
		for action in current_skill:
			$AnimationPlayer.play(action.animation,-1, action.animation_speed)
			current_action = action
			yield($AnimationPlayer, "animation_finished")
	
	
var hit_targets = []

func _on_Hit_area_entered(area:Area2D):
#	area.make_damage(name, '100点')
#	print('owner is ', area.owner.name)
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
			(area as Hurt).make_damage(name, "%s %d"%[current_action.animation, current_action.damage])
