extends RigidBody2D
class_name Obstaculo

enum TIPO_OBSTACULO {ROCAS,BACHE,AUTO}
@export var tipo : TIPO_OBSTACULO = TIPO_OBSTACULO.ROCAS

@onready var roca_obstaculo: Sprite2D = $RocaObstaculo
@onready var bache_obstaculo: Sprite2D = $BacheObstaculo


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	roca_obstaculo.visible = false
	bache_obstaculo.visible = false
	
	match tipo:
		TIPO_OBSTACULO.ROCAS:
			roca_obstaculo.visible = true
		TIPO_OBSTACULO.BACHE:
			bache_obstaculo.visible = true
		_:
			roca_obstaculo.visible = true
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
