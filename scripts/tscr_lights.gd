extends OmniLight3D

const LIGHT_SPEED = 6
const LIGHT_POS_MAX = 10

@onready var light_r = self
@onready var light_l = $"../outside_light_l"

func _process(delta):
    if light_r.position.x >= LIGHT_POS_MAX:
        light_r.position.x = -LIGHT_POS_MAX
    else:
        light_r.position.x += LIGHT_SPEED * delta

    light_l.position.x = light_r.position.x
