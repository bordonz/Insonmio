extends Control

# Configura las velocidades de parallax por capas
@export_group("Velocidades de Parallax")
@export var fuerza_fondo: float = 2.0      # Luna y fondo
@export var fuerza_capa_1: float = 6.0     # Nubes 1
@export var fuerza_capa_2: float = 10.0    # Nubes 2
@export var fuerza_capa_3: float = 14.0    # Nubes 3
@export var fuerza_capa_4: float = 20.0    # Nubes 4 (las más cercanas)

@export_group("Suavizado")
@export var velocidad_suavizado: float = 5.0

# Estructura interna para guardar nodos y sus posiciones iniciales
var elementos_parallax: Array[Dictionary] = []

func _ready() -> void:
	abrir_ojos()
	# 1. Capa de Fondo lejana (Luna)
	_registrar_nodo($Luna, fuerza_fondo)
	
	# 2. Capa 1 (Nubes 1)
	_registrar_nodo($Nube1Izq, fuerza_capa_1)
	_registrar_nodo($Nube1Der, fuerza_capa_1)
	
	# 3. Capa 2 (Nubes 2)
	_registrar_nodo($Nube2Der, fuerza_capa_2)
	_registrar_nodo($Nube2Izq, fuerza_capa_2)
	
	# 4. Capa 3 (Nubes 3)
	_registrar_nodo($Nube3Izq, fuerza_capa_3)
	_registrar_nodo($Nube3Der, fuerza_capa_3)
	
	# 5. Capa 4 (Nubes 4 - Las más frontales)
	# Nota: get_node() busca nodos que estén anidados dentro de otros en la jerarquía
	_registrar_nodo($Nube3Izq/Nube4Der, fuerza_capa_4)
	_registrar_nodo($Nube4Izq, fuerza_capa_4)

func _registrar_nodo(nodo: Control, fuerza: float) -> void:
	if nodo:
		elementos_parallax.append({
			"nodo": nodo,
			"pos_inicial": nodo.position,
			"fuerza": fuerza
		})

func _process(delta: float) -> void:
	var tamano_pantalla = get_viewport_rect().size
	var pos_mouse = get_global_mouse_position()
	
	# Limitamos el offset entre -0.5 y 0.5 para no exagerar el movimiento
	var offset_centro = (pos_mouse - (tamano_pantalla / 2.0)) / (tamano_pantalla / 2.0)
	offset_centro.x = clamp(offset_centro.x, -0.5, 0.5)
	offset_centro.y = clamp(offset_centro.y, -0.5, 0.5)
	
	for elem in elementos_parallax:
		var nodo = elem["nodo"] as Control
		var pos_destino = elem["pos_inicial"] + (offset_centro * elem["fuerza"])
		nodo.position = nodo.position.lerp(pos_destino, delta * velocidad_suavizado)


@onready var parpado_superior: ColorRect = $ParpadoSuperior
@onready var parpado_inferior: ColorRect = $ParpadoInferior

func abrir_ojos(duracion: float = 1.2) -> void:
	var tamano_pantalla = get_viewport_rect().size
	var alto_parpado = parpado_superior.size.y # Obtiene la altura real del párpado
	
	var tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	# El párpado superior sube hasta quedar completamente fuera por ARRIBA (-alto_parpado)
	tween.tween_property(parpado_superior, "position:y", -alto_parpado, duracion)
	
	# El párpado inferior baja hasta quedar completamente fuera por ABAJO (tamano_pantalla.y)
	tween.tween_property(parpado_inferior, "position:y", tamano_pantalla.y, duracion)
