extends Sprite2D

@onready var player = $Player
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(GameManager.Spawn_Player):
		GameManager.Spawn_Player = false
		player.position = GameManager.Spawn_Point

