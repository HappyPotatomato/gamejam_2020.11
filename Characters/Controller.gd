#controller.gd
#Parente tem que ser RigidBody2D
extends Node

#Variáveis constantes
const RIGHT = Vector2(1,0)
const LEFT 	= Vector2(-1,0)
const DOWN 	= Vector2(0,1)
const UP 	= Vector2(0,-1)

#Variáveis editáveis no Inspector
export var speed = 200
export var jump_height = 1000

#Variáveis
var motion = Vector2()
var input_disabled = false

#Node
onready var rb = self.get_parent()

func _ready():
	pass

func move(input_right,input_left,input_jump,delta):
	#Verifica se o parente é do tipo exigido
	if verify() == false:
		print("Parent is invalid! Parent must be RigidBody2D")
		return 0
	
	#Checa se o input tá habilitado
	if input_disabled == true:
		pass
	else:
		#Pro movimento horizontal
		if input_right == true and input_left == true:
			motion.x = 0
		elif input_right == true:
			motion.x = speed
		elif input_left == true:
			motion.x = -speed
		else:
			motion.x = 0
		
		#Pra pular
		if rb.test_motion(DOWN) and input_jump == true:
			motion.y = -jump_height
		
		rb.apply_central_impulse(motion)
		
		motion.y = 0

func verify():
	if rb.is_class("RigidBody2D"):
		return true
	else:
		print("Failed to verify")
		return false
