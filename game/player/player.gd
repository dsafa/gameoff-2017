extends KinematicBody2D

var velocity = Vector2()
const SPEED = 15000
const FRICTION = -900

var pos = Vector2()

func _ready():
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	var velocity = Vector2()
	velocity.x = Input.is_action_pressed("ui_right") - Input.is_action_pressed("ui_left")
	velocity.y = Input.is_action_pressed("ui_down") - Input.is_action_pressed("ui_up")
	
	velocity = velocity.normalized() * SPEED * delta
	
	var extra = move(velocity * delta)
	if is_colliding():
		var collider = get_collider()
		if (collider extends RigidBody2D):
            collider.apply_impulse(extra, collider.get_pos() - get_collision_pos())

		var normal = get_collision_normal()
		velocity = normal.slide(extra)
		move(normal.slide(extra))