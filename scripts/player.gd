extends CharacterBody2D

# receives game start
var can_move
func _on_control_start_game() -> void:
	show()
	can_move = true

# jump logic
const gravity = 400
var jump_power = 600
var x_accel = 100
var can_jump

#dash vars
var dashing = false
var last_direction
var direction
var can_dash
var dash_on_cd = false

func _physics_process(delta: float) -> void:

#direction detection, prints speed/direction
	direction = Input.get_axis("ui_left", "ui_right")
	if not direction == 0 and dashing == false:
		last_direction = direction
	#print(velocity.x, " ", velocity.y, " ", last_direction, " ", can_dash, " ", dashing)

# gravity
	if can_move == true:
		if not is_on_floor() and velocity.y <= 600:
			velocity.y += gravity * delta

# handles jump
		if is_on_floor() and !Input.is_action_pressed("ui_accept") and !dashing == true:
			can_jump = true
		if velocity.y <= -135 or is_on_ceiling() or Input.is_action_just_released("ui_accept") or velocity.y >= 15 or dashing == true:
			can_jump = false
		if Input.is_action_pressed("ui_accept") and can_jump == true:
			velocity.y += -(jump_power * delta)
		if Input.is_action_just_pressed("ui_accept") and can_jump == true:
			velocity.y += -95
		if direction and dashing == false:
			velocity.x = direction * x_accel
		else:
			velocity.x = move_toward(velocity.x, 0, x_accel)

#handles dash
		if is_on_floor() and !Input.is_action_pressed("run") and !dashing == true:
			can_dash = true
		if Input.is_action_just_pressed("run") and can_dash == true and dash_on_cd == false:
			dashing = true
			velocity.x = 300 * last_direction
			start_dash_cd.emit()
			dash_on_cd = true
		if dashing == true:
			velocity.y = 0
			velocity.x += 150 * last_direction
		if dashing == true and is_on_wall():
			can_dash = false
		if is_on_wall() or abs(velocity.x) >= 750:
			dashing = false
		if abs(velocity.x) >= 750:
			can_dash = false
			velocity.x = 150 * last_direction

		move_and_slide()

#emits signals for attacks
		if Input.is_action_just_pressed("attack") and is_on_floor() and !Input.is_action_pressed("ui_up"):
			if last_direction == -1:
				slash_left.emit()
				print("left")
			if last_direction == 1:
				slash_right.emit()
				print("right")
		if Input.is_action_just_pressed("attack") and !Input.is_action_pressed("ui_up") and !Input.is_action_pressed("ui_down"):
			if last_direction == -1:
				slash_left.emit()
				print("left")
			if last_direction == 1:
				slash_right.emit()
				print("right")
		elif Input.is_action_just_pressed("attack") and Input.is_action_pressed("ui_up"):
			slash_up.emit()
			print("up")
		elif Input.is_action_just_pressed("attack") and Input.is_action_pressed("ui_down") and !is_on_floor():
			slash_down.emit()
			print("down")

# emits xpos for enemy tracking
	player_xpos.emit(position.x)
signal player_xpos(x)

#signals for dash cooldown
signal start_dash_cd()
func _on_dash_cd_timeout() -> void:
	dash_on_cd = false

#handles death, remember to add Area2Ds with 2,2 collisions to interact with this
var spawn = Vector2(0, 0)
func _on_area_2d_area_entered(area: Area2D) -> void:
	self.position = spawn

func death():
	can_move = false

#signals for attack
signal slash_left
signal slash_right
signal slash_up
signal slash_down
