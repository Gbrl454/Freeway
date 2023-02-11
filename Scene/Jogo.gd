extends Node

const CENA_CARROS = preload("res://Scene/Carros.tscn")

var pistas_rapidas = [104, 272, 488]
var pistas_lentas = [160, 216, 324, 384, 438, 544, 600]
var score = 0

func _ready():
	$AudioTema.play()
	$HUD/Mensagem.text = ""
	$HUD/Button.hide()
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
	if score >= 1:
		$AudioTema.stop()
		$AudioVitoria.play()
		$TimerCarrosRapido.stop()
		$TimerCarrosLento.stop()
		$HUD/Mensagem.text = "Player Ganhou!"
		$HUD/Button.show()
	else:
		$HUD/Placar.text = str(score)
		$AudioPonto.play()


func _on_HUD_reinicia():
	score = 0
	$Player.position = $Player.posicao_inicial
	$AudioTema.play()
	$TimerCarrosRapido.start()
	$TimerCarrosLento.start()
	$HUD/Mensagem.text = ""
	$HUD/Placar.text = "0"
	$HUD/Button.hide()
	print_debug('reiniciou')
