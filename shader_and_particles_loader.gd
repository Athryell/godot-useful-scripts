extends CanvasLayer
## It preload all the shaders and particles to avoid stuttering and lags while playing
## Add a black ColorRect as a child and increase z-index

@export var materials: Array[Material]
@export var particles: Array[PackedScene]

func _ready():
	await _load_materials()
	await _load_particles()
	SceneManager.change_scene(SceneManager.Scene.STARTING_SCREEN)

func _load_materials():
	var sprites = []
	for material in materials:
		var sprite = Sprite2D.new()
		sprite.texture = PlaceholderTexture2D.new()
		sprite.material = material
		add_child(sprite)
		sprites.append(sprite)
	
	await get_tree().create_timer(0.2).timeout
	for sprite in sprites:
		sprite.queue_free()


func _load_particles():
	var part = []
	for p in particles:
		var node_p = p.instantiate()
		add_child(node_p)
		part.append(node_p)
	await get_tree().create_timer(0.2).timeout
	for p in part:
		p.queue_free()
		
