extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_tree().create_timer(5),"timeout")
	$AnimationPlayer.play("slash")


func effect(key_name:String):
	print(key_name)
	var skill_data = {
		effects={
			slash_0={
				name="Swoosh2",
				offset=Vector2(100,0)
			}
		}
	}
	var effect = skill_data.effects[key_name]
	print('创建特效 ',effect)
