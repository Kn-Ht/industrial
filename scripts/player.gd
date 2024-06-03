extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var mouse_sens = 0.1
var camera_anglev=0
@onready var view = $view

func _ready():
    Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):  		
    if event is InputEventMouseMotion:
        # Rotate the view horizontally
        rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
        
        # Calculate the potential new vertical angle
        var changev = -event.relative.y * mouse_sens
        var new_camera_anglev = camera_anglev + changev
        
        # Clamp the vertical angle to avoid flipping
        new_camera_anglev = clamp(new_camera_anglev, -50, 50)
        
        # Apply the actual change in vertical angle after clamping
        camera_anglev = new_camera_anglev
        
        # Ensure the camera angle remains consistent
        view.rotation_degrees.x = camera_anglev

func _physics_process(delta):
    # Add the gravity.
    if not is_on_floor():
        velocity.y -= gravity * delta

    # Handle jump.
    if Input.is_action_just_pressed("ui_accept") and is_on_floor():
        velocity.y = JUMP_VELOCITY

    # Get the input direction and handle the movement/deceleration.
    # As good practice, you should replace UI actions with custom gameplay actions.
    var input_dir = Input.get_vector("mv_left", "mv_right", "mv_forward", "mv_back")
    var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
    if direction:
        velocity.x = direction.x * SPEED
        velocity.z = direction.z * SPEED
    else:
        velocity.x = move_toward(velocity.x, 0, SPEED)
        velocity.z = move_toward(velocity.z, 0, SPEED)

    move_and_slide()
