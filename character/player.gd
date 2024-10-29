extends CharacterBody2D
class_name Player
const speed = 200
var player_state
var rayvalue
var notebook

@onready var interactdetect = $RayCast2D

func _ready():
	pass

func _process(delta):
	_interact()
	

func _physics_process(delta):
	#Movement
	var direction  = Input.get_vector("left", "right", "up", "down")
	
	if direction.x == 0 and direction.y == 0:
		player_state = "idle"
	elif direction.x != 0 or direction.y != 0:
		player_state = "walking"	

	velocity = direction * speed
	move_and_slide()
	
	play_anim(direction)
	
	#Interaction
	if $RayCast2D.is_colliding():
		var collider = $RayCast2D.get_collider()
		if collider.is_in_group("interact"):
			$interacticon.global_position = collider.global_position
			$interacticon.position.y -= 20
			$interacticon.visible = true
			$interacticon.play("default")
		else:
			$interacticon.visible = false
	else:
		$interacticon.visible = false

func play_anim(dir):
	if player_state == "idle":
		if Input.is_action_just_released("up"):
			rayvalue = Vector2(0, -18)
			$AnimatedSprite2D.play("n-idle")
			$RayCast2D.set_target_position(rayvalue)
		
		elif Input.is_action_just_released("down"):
			rayvalue = Vector2(0, 18)
			$AnimatedSprite2D.play("s-idle")
			$RayCast2D.set_target_position(rayvalue)
			
		elif Input.is_action_just_released("right"):
			rayvalue = Vector2(18, 0)
			$AnimatedSprite2D.play("e-idle")
			$RayCast2D.set_target_position(rayvalue)
		
		elif Input.is_action_just_released("left"):
			rayvalue = Vector2(-18, 0)
			$AnimatedSprite2D.play("w-idle")
			$RayCast2D.set_target_position(rayvalue)


	if player_state == "walking":
		$CollisionShape2D.disabled = false
		if dir.y < 0:
			rayvalue = Vector2(0, -18)
			$RayCast2D.set_target_position(rayvalue)
			$AnimatedSprite2D.play("n-walk")
		elif dir.y > 0:
			rayvalue = Vector2(0, 18)
			$RayCast2D.set_target_position(rayvalue)
			$AnimatedSprite2D.play("s-walk")
		elif dir.x > 0:	
			rayvalue = Vector2(18, 0)
			$RayCast2D.set_target_position(rayvalue)
			$AnimatedSprite2D.play("e-walk")
		elif dir.x < 0:
			rayvalue = Vector2(-18, 0)
			$RayCast2D.set_target_position(rayvalue)
			$AnimatedSprite2D.play("w-walk")

func _interact():
	if $RayCast2D.is_colliding() and Input.is_action_just_pressed("interact"):
		var collider = $RayCast2D.get_collider()
		if collider is ChairArea:
			$CollisionShape2D.disabled = true
			global_position = collider.global_position
			print("Chair interaction registered.")
			$AnimatedSprite2D.play("sit")

		elif collider.is_in_group("evidence"):
			collider.form_interaction()


		elif collider.is_in_group("misc"):
			print("Just a paper.")
			

