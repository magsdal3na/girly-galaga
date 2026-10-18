extends Marker2D

@export var collectible_scene: PackedScene
@export var spawn_count: int = 15 #how many items to scatter
@export var spawn_area_size: Vector2 = Vector2(640, 640)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scatter_items()
	
func scatter_items() -> void:
	if not collectible_scene:
		push_error("Collectible scene is missing!")
		return
		
	for i in range(spawn_count):
		#generates a random X and Y coordinate w/in the size
		var random_x = randf_range(0, spawn_area_size.x)
		var random_y = randf_range(0, spawn_area_size.y)
		
		#instantiate the item
		var item = collectible_scene.instantiate()
		
		#position the item relative to spawn location
		item.position = Vector2(random_x, random_y)
		
		#add to the tree
		add_child(item)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
