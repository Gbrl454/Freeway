extends Area2D

export var speed = 100
var speedR = speed

var screen_size
var posicao_inicial = Vector2(640, 690)
var mortes = 0
var idPlayer = 0

signal pontua
signal plusCoin
var playing = true

func _ready():
	screen_size = get_viewport_rect().size
	
func _process(delta):
	if playing == true:
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
			$Anim.animation = "down%s"%[idPlayer]
		if velocity.y < 0:
			$Anim.animation = "up%s"%[idPlayer]
			
		if velocity.x < 0 && velocity.y == 0:
			$Anim.animation = "left%s"%[idPlayer]
		if velocity.x > 0 && velocity.y == 0:
			$Anim.animation = "right%s"%[idPlayer]
		
		position += velocity * delta
		position.y = clamp(position.y, 0, screen_size.y)

func _on_Player_body_entered(body):
	match body.name:
		"LinhaChegada":
			emit_signal("pontua")
			position = posicao_inicial
	if "Carros" in body.name:
			$Audio.play()
			mortes += 1
			position = posicao_inicial

func _getCoin():
	emit_signal("plusCoin")

func _Reset():
	mortes = 0
	_Play(true)
	position = posicao_inicial

func _Play(p):
	playing = p
	if p == false:
		$Anim.stop()
		hide()
	else:
		show()
