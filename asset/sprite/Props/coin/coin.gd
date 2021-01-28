extends Sprite

onready var player:AnimationPlayer = $AnimationPlayer
onready var audio_player:AudioStreamPlayer2D = $AudioStreamPlayer2D

func _on_Area2D_body_entered(body):
	$Area2D.hide()
	player.play("fade_out")
	audio_player.play()
	yield(player, "animation_finished")
	queue_free()
