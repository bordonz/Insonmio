extends Node2D


var obstaculo = preload("res://prefabs/obstaculo.tscn")
@export var maxTimer = 1
var timer = maxTimer
@export var velocidadObstaculo : int = 128


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer = maxTimer
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timer > 0:
		timer -= 1
	else:
		timer = maxTimer
		var instance = obstaculo.instantiate()
		
		instance.global_position.y = 0
		instance.global_position.x = 40 * randi_range(-2,2) #randi_range(-100,100)
		instance.linear_velocity.y = velocidadObstaculo
		instance.tipo = instance.TIPO_OBSTACULO.values().pick_random()
		add_child(instance)
		#print("objeto creado")
	pass
