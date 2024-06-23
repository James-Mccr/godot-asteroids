extends Area2D

const velocity = Vector2(0, -5.5)

func _process(delta):
	position += velocity.rotated(rotation)
	if (!$VisibleOnScreenNotifier2D.is_on_screen()):
		hide()
		queue_free()

func _on_body_entered(body):
	body.hide()
	body.queue_free()
	hide()
	queue_free()
