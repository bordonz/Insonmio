extends Control

@onready var descripcion_label: Label = $Descipcion
@onready var presionar_label: Label = $Presionar
@export var musica_intro: AudioStream 

var esperando_click: bool = true
var escribiendo: bool = false

func _ready() -> void:
	if musica_intro:
		AudioManager.reproducir_musica(musica_intro)
	descripcion_label.visible = false
	
func _al_terminar_tipeo() -> void:
	$AnimationPlayer.play("animacion_dialogos")

func _input(event: InputEvent) -> void:
	if esperando_click and ((event is InputEventMouseButton and event.pressed) or (event is InputEventKey and event.pressed)):
		esperando_click = false
		iniciar_efecto_escritura()

func iniciar_efecto_escritura() -> void:
	escribiendo = true
	if presionar_label:
		presionar_label.visible = false
	

	descripcion_label.visible = true
	descripcion_label.visible_ratio = 0.0
	

	var tween = create_tween()
	tween.tween_property(descripcion_label, "visible_ratio", 1.0, 10.0)
	await tween.finished
	_al_terminar_tipeo()

# Funcion generica que llama al AnimationPlayer
func animar_dialogo(label_path: NodePath, duracion: float = 3.0) -> void:
	var label_objetivo = get_node_or_null(label_path) as Label
	if label_objetivo:
		label_objetivo.visible = true
		label_objetivo.visible_ratio = 0.0
		
		var tween = create_tween()
		tween.tween_property(label_objetivo, "visible_ratio", 1.0, duracion)


@onready var parpado_superior: ColorRect = $ParpadoSuperior
@onready var parpado_inferior: ColorRect = $ParpadoInferior

func cerrar_ojos_y_cambiar_escena(duracion_cierre: float = 1.2) -> void:
	var tamano_pantalla = get_viewport_rect().size
	var mitad_alto = tamano_pantalla.y / 2.0
	var tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	tween.tween_property(parpado_superior, "position:y", 0.0, duracion_cierre)
	tween.tween_property(parpado_inferior, "position:y", mitad_alto, duracion_cierre)
	
	await tween.finished
	await get_tree().create_timer(0.3).timeout
	get_tree().change_scene_to_file("res://Menu/Menu.tscn") 
