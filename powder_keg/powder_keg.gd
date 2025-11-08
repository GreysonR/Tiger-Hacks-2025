extends Character

@onready var ExplosionScene = preload("res://powder_keg/powder_keg_explosion.tscn")
@onready var healthbar = %Healthbar

func _ready():
	healthbar.set_health(max_health, max_health)

func _on_damaged(new_health: int, _damage: int) -> void:
	healthbar.set_health(new_health, max_health)

func _on_died() -> void:
	queue_free()
	
	var explosion = ExplosionScene.instantiate()
	explosion.position = global_position
	get_tree().root.add_child(explosion)
	
	
