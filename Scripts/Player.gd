extends Area2D

export var speed = 100
var speedR = speed

var screen_size
var posicao_inicial = Vector2(640, 690)

signal pontua
signal plusCoin

func _ready():
	_Reset()
	
func _process(delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		Global.scene = get_tree().change_scene("res://Scene/Main.tscn")

	if Global.playing == true:
		var velocity = Vector2()
		if Input.is_key_pressed(KEY_SHIFT):
			speedR = speed*2
		else:
			speedR = speed
		if Input.is_action_pressed("ui_up"):
			velocity.y -= 1
		if Input.is_action_pressed("ui_down"):
			velocity.y += 1
		if Input.is_action_pressed("ui_left"):
			velocity.x -= 1
		if Input.is_action_pressed("ui_right"):
			velocity.x += 1
		velocity = velocity.normalized() * speedR
		if velocity.length() > 0:
			$Anim.play()
		else:
			$Anim.stop()
		if velocity.y > 0:
			$Anim.animation = "down%s"%[Global.idPlayer]
		if velocity.y < 0:
			$Anim.animation = "up%s"%[Global.idPlayer]
			
		if velocity.x < 0 && velocity.y == 0:
			$Anim.animation = "left%s"%[Global.idPlayer]
		if velocity.x > 0 && velocity.y == 0:
			$Anim.animation = "right%s"%[Global.idPlayer]
		
		position += velocity * delta
		position.y = clamp(position.y, 0, screen_size.y)

func _on_Player_body_entered(body):
	if Global.playing == true:
		match body.name:
			"LinhaChegada":
				emit_signal("pontua")
				position = posicao_inicial
		if "Carros" in body.name:
				$Audio.play()
				Global.mortes += 1
				position = posicao_inicial

func _getCoin():
	emit_signal("plusCoin")

func _Reset():
	$Anim.animation = "up%s"%[Global.idPlayer]
	screen_size = get_viewport_rect().size
	_Play(true)
	position = posicao_inicial

func _Play(p):
	Global.playing = p
	if p == false:
		$Anim.stop()
		hide()
	else:
		show()
