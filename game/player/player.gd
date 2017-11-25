extends KinematicBody2D

const SPEED = 15000
const FRICTION = -900
const PROJECTILE_SPEED = 300

var pos = Vector2()
var world_node

onready var projectile_scene = preload("res://player/projectile.tscn")

func init(world):
	world_node = world

func _ready():
	set_fixed_process(true)
	set_process_input(true)
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
		
func _input(event):
	if event.type == InputEvent.MOUSE_BUTTON:
		if event.is_action_pressed("mouse_down"):
			var direction = (get_global_mouse_pos() - get_pos()).normalized()
			var projectile = projectile_scene.instance()
			projectile.set_pos(get_pos() + direction * 70)
			projectile.apply_impulse(Vector2(), direction * PROJECTILE_SPEED)
			world_node.add_child(projectile)