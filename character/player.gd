extends CharacterBody2D
class_name Player
const speed = 200
enum State { IDLE, WALKING, DISABLED }
var player_state = State.IDLE
var rayvalue
@export var ray : RayCast2D



func _ready():
	player_state = State.IDLE

func _process(delta):
	if player_state != State.DISABLED:
		_interact()

func _physics_process(delta):
	if player_state != State.DISABLED:
		handle_movement()
	#Movement
func handle_movement():
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if direction == Vector2.ZERO:
		player_state = State.IDLE
	else:
		player_state = State.WALKING
		velocity = direction * speed
		move_and_slide()

	play_anim(direction)
	
	#Interaction
	if $RayCast2D.is_colliding():
		var collider = $RayCast2D.get_collider()
		if collider:
			if collider.is_in_group("interact") or collider.is_in_group("npc"):
				$interacticon.global_position = collider.global_position
				$interacticon.position.y -= 20
				$interacticon.visible = true
				$interacticon.play("default")
		else:
			$interacticon.visible = false
	else:
		$interacticon.visible = false

func play_anim(dir):
	if player_state == State.IDLE:
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


	elif player_state == State.WALKING:
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
			rayvalue = Vector2(50, 0)
			$RayCast2D.set_target_position(rayvalue)

		elif collider.is_in_group("evidence"):
			collider.form_interaction()
			await Dialogic.timeline_started
			disable_input()
			await Dialogic.timeline_ended
			enable_input()

		elif collider.is_in_group("npc"):
			collider.start_dialogue()
			await Dialogic.timeline_started
			disable_input()
			await Dialogic.timeline_ended
			enable_input()
		
		elif collider.is_in_group("map"):
			collider.travel()
			print("Map")

func disable_input():
	player_state = State.DISABLED

func enable_input():
	player_state = State.IDLE
