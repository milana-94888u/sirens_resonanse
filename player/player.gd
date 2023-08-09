extends CharacterBody2D
class_name Player


@export var speed := 200
@export var health := 1


var current_interact_object: Siren = null


func go_right() -> void:
	velocity = Vector2.RIGHT * speed


func go_down() -> void:
	velocity = Vector2.DOWN * speed

func go_left() -> void:
	velocity = Vector2.LEFT * speed

func go_up() -> void:
	velocity = Vector2.UP * speed


func move() -> void:
	move_and_slide()


func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("ui_right"):
		go_right()
		move()
	elif Input.is_action_pressed("ui_down"):
		go_down()
		move()
	elif Input.is_action_pressed("ui_left"):
		go_left()
		move()
	elif Input.is_action_pressed("ui_up"):
		go_up()
		move()
	elif Input.is_action_just_pressed("interact"):
		if current_interact_object != null:
			current_interact_object.interact()


func set_active_object(obj: Siren) -> void:
	if current_interact_object != null and current_interact_object != obj:
		current_interact_object.set_outline(false)
	current_interact_object = obj
	current_interact_object.set_outline(true)


func remove_active_object(obj: Siren) -> void:
	if current_interact_object == obj:
		current_interact_object.set_outline(false)
		current_interact_object = null
	get_tree().call_group("sirens", "check_for_player", self)