extends RigidBody2D

var velocity
var pos

func init(pos, velocity):
	set_pos(pos)
	apply_impulse(Vector2(0,0), velocity)

func _ready():
	
	pass

func _draw():
	draw_circle(Vector2(0,0), 5, Color(100, 100, 100))
	
func _integrate_forces(state):
		