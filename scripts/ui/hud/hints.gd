extends Control


func set_text(text: String):
	$TextureRect/Label.text = text

func play_animation():
	$AnimationPlayer.play("spawn")
