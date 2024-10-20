class_name level_camera
extends Node3D

var min_zoom = -4
var max_zoom = 5
var zoom = 0 :
	set(value):
		zoom = clamp(value, min_zoom, max_zoom)

@onready var camera : Camera3D = $Camera3D
@onready var mesh: MeshInstance3D = $MeshInstance3D


func _ready() -> void:
	mesh.hide()


func _physics_process(delta: float) -> void:
	get_move_input(delta)
	camera_zoom(delta)

func _input(_event: InputEvent) -> void:
	var rotate_dir = Input.get_axis("rotate_right", "rotate_left")
	if Input.is_action_just_pressed("rotate_left") or Input.is_action_just_pressed("rotate_right"):
		camera_rotation(rotate_dir)


func get_move_input(delta: float):
	var move_speed = 5.0
	var forward = transform.basis.z.normalized() * move_speed
	if Input.is_action_pressed("left"):
		transform.origin += forward.cross(Vector3.UP) * delta
	if Input.is_action_pressed("right"):
		transform.origin -= forward.cross(Vector3.UP) * delta
	if Input.is_action_pressed("up"):
		transform.origin -= forward * delta
	if Input.is_action_pressed("down"):
		transform.origin += forward * delta


func camera_rotation(dir: int) -> void:
	var degrees = 45
	rotation_degrees.y += degrees * dir


func camera_zoom(delta: float) -> void:
	var zoom_speed = 20
	if Input.is_action_just_pressed("zoom out"):
		zoom += zoom_speed * delta
		camera.position.y = zoom
		camera.position.z = zoom
	if Input.is_action_just_pressed("zoom in"):
		zoom -= zoom_speed * delta
		camera.position.y = zoom
		camera.position.z = zoom
