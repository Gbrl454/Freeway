extends Node

const CENA_CARROS = preload("res://Scene/Carros.tscn")

var pistas_rapidas = [104, 272, 488]
var pistas_lentas = [160, 216, 324, 384, 438, 544, 600]
var score = 0

func _ready():
	$AudioTema.play()
	$HUD._Reset()
	$Player._Reset()
	randomize()

func _on_TimerCarrosRapido_timeout():
	var novo_carro = CENA_CARROS.instance()
	add_child(novo_carro)
	var pista = pistas_rapidas[randi() % pistas_rapidas.size()]
	novo_carro.position = Vector2(-10, pista)
	novo_carro.linear_velocity.x = rand_range(700, 710)
	novo_carro.linear_damp = -1
	
func _on_TimerCarrosLento_timeout():
	var novo_carro = CENA_CARROS.instance()
	add_child(novo_carro)
	var pista = pistas_lentas[randi() % pistas_lentas.size()]
	novo_carro.position = Vector2(-10, pista)
	novo_carro.linear_velocity.x = rand_range(300, 310)
	novo_carro.linear_damp = -1

func _on_Player_pontua():
	score += 1
	$HUD/Placar.text = str(score)
	$AudioPonto.play()
	if score >= 5:
		$AudioTema.stop()
		$TimerCarrosRapido.stop()
		$TimerCarrosLento.stop()
		$HUD._Stats($Player.mortes)
		$Player._Play(false)
		$AudioVitoria.play()

func _on_HUD_reinicia():
	score = 0
	$AudioTema.play()
	$TimerCarrosRapido.start()
	$TimerCarrosLento.start()
	$HUD._Reset()
	$Player._Reset()
