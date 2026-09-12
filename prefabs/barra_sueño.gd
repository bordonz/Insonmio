extends Node2D
class_name BarraSueno

var sueño : float = 1.0
@onready var nivelSueno: Label = $Label
@onready var barra: Sprite2D = $fondo

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func getSueno():
	return sueño
func setSueno(sueno : float):
	sueño = sueno
	sueño = clamp(sueño,0,1)
func hit(penalty : float):
	sueño -= penalty
	if sueño <= 0:
		get_tree().reload_current_scene()
	sueño = clamp(sueño,0,1)
func refill():
	sueño = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Decrementar sueño
	#if sueño > 0:
		#sueño -= delta * 0.01
	#else:
		#print("despertar")
	
	# Actualizar texto
	nivelSueno.text = str(sueño)
	
	barra.scale.y = 300*(sueño)
	#print(barra.scale.y)
	
	
