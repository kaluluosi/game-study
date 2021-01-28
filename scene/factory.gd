extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var btn_left = $UI/left
onready var btn_right = $UI/right

# Called when the node enters the scene tree for the first time.
func _ready():
	btn_left.connect("button_down", self, '_action', ['left'])
	btn_right.connect("button_down", self, '_action', ['right'])
	
func _action(name:String):
	$Player1.apply_central_impulse(Vector2.UP*400)



