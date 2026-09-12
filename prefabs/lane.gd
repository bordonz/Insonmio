extends Node2D

@export var laneSpeed = 2
var laneTimer = laneSpeed
@export var lane: Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if laneTimer > 0:
		laneTimer -= delta
		#lane.position.y += 10
		lane.region_rect.position.y-=2.5
	else:
		#lane.position.y = 0
		#lane.region_rect.position.y=0
		laneTimer = laneSpeed
		
		
	pass
