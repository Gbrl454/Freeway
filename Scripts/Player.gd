extends Node2D

export var speed = 100
var speedR = speed

var screen_size
var posicao_inicial = Vector2(640, 690)
var mortes = 0

signal pontua
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
			$Anim.animation = "baixo"
		else:
			$Anim.animation = "cima"
		position += velocity * delta
		position.y = clamp(position.y, 0, screen_size.y)

func _on_Player_body_entered(body):
	if body.name == "LinhaChegada":
		emit_signal("pontua")
	else:
		$Audio.play()
		mortes += 1
	position = posicao_inicial

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
