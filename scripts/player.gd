extends CharacterBody3D

var SPEED: float = 5.1
const SPRINTING_SPEED = 8.0
const CROUCH_SPEED = 3.0
const JUMP_VELOCITY = 9.5

const MOUSE_SENSE = 0.4





const LERP_SPEED = 10.0

@onready var move_to = $head/look_at
@onready var camera = $head/Camera3D
@onready var head = $head
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass

var input_dir = Input.get_vector("forward", "backward", "left", "right" )
func _input(event):
	input_dir = Input.get_vector("forward", "backward", "left", "right" )
	
	if not event is InputEventMouseMotion: return
	rotate_y(-deg_to_rad(event.relative.x * MOUSE_SENSE))
	camera.rotate_x(-deg_to_rad(event.relative.y * MOUSE_SENSE))
	camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-89),  deg_to_rad(89))

var currentSpeed = 10
var direction = Vector3.ZERO
func _physics_process(delta):
	
	
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	
	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	input_dir = Input.get_vector( "left", "right", "forward", "backward" )
	direction = lerp(direction, (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized(), delta * LERP_SPEED)
	if direction:
		velocity.x = direction.x * currentSpeed
		velocity.z = direction.z * currentSpeed
	else:
		velocity.x = move_toward(velocity.x, 0, currentSpeed)
		velocity.z = move_toward(velocity.z, 0, currentSpeed)

	move_and_slide()
