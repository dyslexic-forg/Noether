extends Node2D

enum Direcao {CIMA, BAIXO, DIREITA, ESQUERDA}

var direcao
var movendo = false
var tamanho_tile = 32  # Tamanho de cada tile na grade

func _ready():
	direcao = Direcao.BAIXO

func _process(delta):
	if not movendo:
		processar_input()

func processar_input():
	if Input.is_action_pressed("ui_down"):
		direcao = Direcao.BAIXO
		iniciar_movimento(Vector2(0, 1))
	elif Input.is_action_pressed("ui_up"):
		direcao = Direcao.CIMA
		iniciar_movimento(Vector2(0, -1))
	elif Input.is_action_pressed("ui_right"):
		direcao = Direcao.DIREITA
		iniciar_movimento(Vector2(1, 0))
	elif Input.is_action_pressed("ui_left"):
		direcao = Direcao.ESQUERDA
		iniciar_movimento(Vector2(-1, 0))

func iniciar_movimento(direcao_vetor):
	if not movendo:
		$AnimatedSprite2D.play("andando para frente")
		movendo = true
		var destino = position + direcao_vetor * tamanho_tile
		
		# Criando um SceneTreeTween
		var tween = create_tween()
		
		# tween_property com até 4 argumentos
		tween.tween_property(self, "position", destino, 0.2)
		
		# Conectar o fim da animação ao callback
		tween.connect("finished", Callable(self, "_on_tween_completed"))

func _on_tween_completed():
	movendo = false
	$AnimatedSprite2D.play("parada de frente")
