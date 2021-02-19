extends Sprite

onready var player:AnimationPlayer = $AnimationPlayer
onready var audio_player:AudioStreamPlayer2D = $AudioStreamPlayer2D

func _on_Area2D_body_entered(body):
	if body is Player:
		$Area2D/CollisionShape2D.set_deferred('disabled', true)
		player.play("fade_out")
		audio_player.play()
		yield(player, "animation_finished")
		queue_free()
