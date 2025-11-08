extends Area2D
class_name Hurtbox

signal take_damage(hitbox: Hitbox)

@export var parent_character: Character


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("hitbox"):
		handle_hitbox_collision(area)

func handle_hitbox_collision(hitbox: Hitbox):
	parent_character.take_damage(hitbox.damage)
	parent_character.take_knockback(hitbox.knockback)
	take_damage.emit(hitbox)
