extends Area2D

var velocity = Vector2.ZERO
const velocity_max = Vector2(1,1)
const base_speed = Vector2(0,-0.02)
const base_rotate = 2.5
const shoot_delay = 1.0
var shoot_delta = 0.0

func _ready():
	position.x = get_viewport_rect().size.x/2
	position.y = get_viewport_rect().size.y/2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (shoot_delta < shoot_delay):
		shoot_delta += delta
		
	if (Input.is_action_pressed("turn_left")):
		rotation_degrees -= base_rotate
	elif (Input.is_action_pressed("turn_right")):
		rotation_degrees += base_rotate
	if (Input.is_action_pressed("move_forward")):
		var velocity_new = velocity + base_speed.rotated(rotation)
		if (velocity_new.x > velocity_max.x):
			velocity_new.x = velocity_max.x
		elif (velocity_new.x < -velocity_max.x):
			velocity_new.x = -velocity_max.x
		if (velocity_new.y > velocity_max.y):
			velocity_new.y = velocity_max.y
		elif (velocity_new.y < -velocity_max.y):
			velocity_new.y = -velocity_max.y
		velocity = velocity_new
	position += velocity
	position.x = wrapf(position.x, 0, get_viewport_rect().size.x)
	position.y = wrapf(position.y, 0, get_viewport_rect().size.y)
	
	if (Input.is_action_pressed("shoot") && shoot_delta >= shoot_delay):
		shoot_delta = 0
		var bullet = load("res://objects/bullet.tscn").instantiate()
		bullet.position = position+Vector2(0,-14).rotated(rotation)
		bullet.rotation = rotation
		get_parent().add_child(bullet)
	
func _on_body_entered(body):
	body.hide()
	hide()
	Signals.gameover.emit()
