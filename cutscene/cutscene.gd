extends Node2D

@onready var d1 = %dialog1
@onready var d2 = %dialog2
@onready var d3 = %dialog3
@onready var d4 = %dialog4
@onready var d5 = %dialog5

var d_index = 0
@onready var d = [d1, d2, d3, d4, d5]

func _ready():
	hide_all()
	d1.visible = true

func hide_all():
	d1.visible = false
	d2.visible = false
	d3.visible = false
	d4.visible = false
	d5.visible = false

func _physics_process(_delta: float) -> void:
	if d_index >= d.size():
		return
	
	if Input.is_action_just_pressed("shoot"):
		d[d_index].visible = false
		d_index += 1
		if d_index >= d.size():
			SceneSwitcher.switch_to_game()
		else:
			d[d_index].visible = true
		
