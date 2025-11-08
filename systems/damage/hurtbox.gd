extends Area2D
class_name Hurtbox

signal take_damage(hitbox: Hitbox)
signal touched(node: Node2D)

var already_hit = []

@export var parent_character: Character
@export var parent_hitbox: CollisionObject2D


func handle_hitbox_collision(hitbox: Hitbox):
	if hitbox == parent_hitbox:
		return
	if already_hit.find(hitbox.get_rid()) != -1:
		return
	already_hit.push_back(hitbox.get_rid())
	parent_character.take_damage(hitbox.damage)
	
	var knockback_dir = (global_position - hitbox.global_position).normalized()
	parent_character.take_knockback(knockback_dir * hitbox.knockback)
	take_damage.emit(hitbox)
	
func handle_box_exit(hitbox: Hitbox):
	if hitbox == parent_hitbox:
		return
	if already_hit.find(hitbox.get_rid()) != -1:
		already_hit.erase(hitbox.get_rid())

func _on_area_entered(area: Area2D) -> void:
	if area == parent_hitbox:
		return
	touched.emit(area)
	if area.is_in_group("Hitbox"):
		handle_hitbox_collision(area)

func _on_body_entered(body: Node2D) -> void:
	if body == parent_hitbox:
		return
	touched.emit(body)
	if body.is_in_group("Hitbox"):
		handle_hitbox_collision(body)

func _on_body_shape_entered(_body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	if body == parent_hitbox:
		return
	touched.emit(body)
	if body.is_in_group("Hitbox"):
		handle_hitbox_collision(body)


func _on_area_exited(area) -> void:
	if area == parent_hitbox:
		return
	if area.is_in_group("Hitbox"):
		handle_box_exit(area)

func _on_body_shape_exited(_body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	if body == parent_hitbox:
		return
	if !body.has_method("is_in_group"):
		return
	if body.is_in_group("Hitbox"):
		handle_box_exit(body)
