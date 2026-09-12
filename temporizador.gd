extends Node2D

@export var tiempo : int
@onready var timer: Timer = $Timer
@onready var label: Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.wait_time = tiempo
	timer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = str(timer.time_left)
	pass


func _on_timer_timeout() -> void:
#	Terminar nivel
	print("Nivel terminado")
	pass # Replace with function body.
