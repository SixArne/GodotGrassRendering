@tool
extends MultiMeshInstance3D

const MeshFactory = preload("mesh_factory.gd")

@export var span: float = 5.0
@export var count: int = 1000
@export var width: Vector2 = Vector2(0.01, 0.02)
@export var height: Vector2 = Vector2(0.04, 0.08)
@export var sway_yaw: Vector2 = Vector2(0.0, 10.0)
@export var sway_pitch: Vector2 = Vector2(0.0, 10.0)

func _init():
	rebuild()

func _ready():
	rebuild()

func rebuild():
	if not multimesh:
		multimesh = MultiMesh.new()
	multimesh.instance_count = 0
	multimesh.mesh = MeshFactory.simple_grass()
	multimesh.transform_format = MultiMesh.TRANSFORM_3D
	multimesh.instance_count = count

	
	for index in multimesh.instance_count:
		var pos = Vector3(randf_range(-span, span), 0.0, randf_range(-span, span))
		var basis = Basis(Vector3.UP, deg_to_rad(randf_range(0, 359)))
		multimesh.set_instance_transform(index, Transform3D(basis, pos))
		multimesh.set_instance_custom_data(index, Color(
			randf_range(width.x, width.y),
			randf_range(height.x, height.y),
			deg_to_rad(randf_range(sway_pitch.x, sway_pitch.y)),
			deg_to_rad(randf_range(sway_yaw.x, sway_yaw.y))
		))
