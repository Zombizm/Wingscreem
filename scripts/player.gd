extends CharacterBody2D

@onready var ray = $RayCast2D
@onready var sprite = $Sprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(_delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if Input.is_action_just_pressed("move_up"):
		move(Vector2.UP)
	elif Input.is_action_just_pressed("move_down"):
		move(Vector2.DOWN)
	elif Input.is_action_just_pressed("move_left"):
		move(Vector2.LEFT)
	elif Input.is_action_just_pressed("move_right"):
		move(Vector2.RIGHT)

	move_and_slide()

func move(direction: Vector2):
	print(direction)
	ray.rotation = direction.angle()
	print(ray.collide_with_bodies)
	if !ray.collide_with_bodies: return
	sprite.rotation = direction.angle()
	self.position += 64 * direction
	
