extends CharacterBody2D

# physics vars
var can_move = false
var x_speed = 15
var direction
const gravity = 200

func _physics_process(delta: float) -> void:
	
# grav
	if !is_on_floor():
		velocity.y += gravity * delta

# follows player xpos
	if can_move == true:
		if player_xpos - position.x <= 150:
			if player_xpos > position.x:
				direction = 1
			if player_xpos < position.x:
				direction = -1
			if knockback == false:
				velocity.x = x_speed*direction
			move_and_slide()


# receives jump countdown
func _on_jump_timer_jump() -> void:
	if can_move == true and is_on_floor() and knockback == false:
		velocity.y = -65

# receives player xpos
var player_xpos
func _player_xpos(x: Variant) -> void:
	player_xpos = x

# receives game start
func _on_game_start() -> void:
	can_move = true
	show()

func _ready():
	var parent = get_parent()
	if parent:
		var main_menu = parent.get_node_or_null("Control")
		main_menu.start_game.connect(_on_game_start)
		
		var player = parent.get_node_or_null("player")
		player.player_xpos.connect(_player_xpos)

var knockback = false
signal getting_hit
func _on_area_2d_area_entered(area: Area2D) -> void:
	if direction == -1:
		velocity.x = 100
		knockback = true
		getting_hit.emit()
	if direction == 1:
		velocity.x = -100
		knockback = true
		getting_hit.emit()


func _kb_ended() -> void:
	knockback = false
