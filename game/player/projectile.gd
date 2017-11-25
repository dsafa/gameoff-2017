extends RigidBody2D

const MAX_BOUNCE = 2
var bounce_count = 0

func _ready():
	set_fixed_process(true)
	pass
	

func _on_projectile_body_enter( body ):
	var bodies = get_colliding_bodies()
	if bodies.size() > 0:
		bounce_count += 1
		if bounce_count >= MAX_BOUNCE:
			queue_free()