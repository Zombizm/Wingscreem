extends RefCounted
class_name Pid3D

var _p: float
var _i: float
var _d: float

var _prev_error: Vector3
var _error_integral: Vector3

func _init(p: float, i: float, d: float):
	_p = p
	_d = d
	_i = i

func update(error: Vector3, delta: float):
	_error_integral += error * delta
	var error_derivative = (error - _prev_error) / delta
	_prev_error = error
	return _p * error + _i * _error_integral + _d * error_derivative
