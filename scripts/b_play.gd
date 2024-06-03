extends Button

func _ready():
    pressed.connect(func():
        # TODO: add transition (with quake textures maybe??)
        get_tree().change_scene_to_file("res://scenes/E1M0.tscn")    
    )

