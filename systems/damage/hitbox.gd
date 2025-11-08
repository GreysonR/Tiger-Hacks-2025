extends Area2D
class_name Hitbox

signal dealt_damage(hurtbox: Hurtbox)
signal touched(node: Node2D)

@export var damage: int = 0
@export var knockback: float = 0.0
@export var single_hit: bool = false

var already_hit = []

func handle_hurtbox_collision(hurtbox: Hurtbox):
	if already_hit.find(hurtbox.get_rid()) != -1:
		return
	already_hit.push_back(hurtbox.get_rid())
	dealt_damage.emit(hurtbox)

func handle_box_exit(hurtbox: Hurtbox):
	if single_hit == false && already_hit.find(hurtbox.get_rid()) != -1:
		already_hit.erase(hurtbox.get_rid())
	
func _on_area_entered(area: Area2D) -> void:
	touched.emit(area)
	if area.is_in_group("Hurtbox"):
		handle_hurtbox_collision(area)


func _on_body_entered(body: Node2D) -> void:
	touched.emit(body)
	if body.is_in_group("Hurtbox"):
		handle_hurtbox_collision(body)

func _on_body_shape_entered(_body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	touched.emit(body)
	if body.is_in_group("Hurtbox"):
		handle_hurtbox_collision(body)


func _on_area_exited(area) -> void:
	if area.is_in_group("Hurtbox"):
		handle_box_exit(area)

func _on_body_shape_exited(_body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	if !body:
		return
	if body.is_in_group("Hurtbox"):
		handle_box_exit(body)
