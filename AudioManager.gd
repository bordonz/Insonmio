extends Node

# Este será nuestro reproductor de música que NUNCA se borra
var reproductor_musica: AudioStreamPlayer

func _ready() -> void:
	# Al iniciar el juego, creamos automáticamente un reproductor de audio
	reproductor_musica = AudioStreamPlayer.new()
	add_child(reproductor_musica)

# Esta función la llamaremos desde cualquier escena para poner música
func reproducir_musica(cancion: AudioStream) -> void:
	# Si la canción que le pasamos ya está sonando, no hacemos nada (para que no se reinicie)
	if reproductor_musica.stream == cancion and reproductor_musica.is_playing():
		return
		
	# Si es una canción nueva o no estaba sonando nada, la reproducimos
	reproductor_musica.stream = cancion
	reproductor_musica.play()
	
