extends Node
class_name LambdaHelper

static func f(lambda:String):
	var _lambda = preload("res://script/Lambda/Lambda.gd")
	return _lambda.new(lambda)


static func eval(code: String, args:Dictionary={}):
	var lines = code.split("\n")
	for ln in len(lines):
		lines[ln] = "\t"+lines[ln]
	
	code = PoolStringArray(lines).join('\n')
	var FORMAT = """func eval({args}):\n\t{express}"""
	
	var args_str = PoolStringArray(args.keys()).join(',')

	var lambda_code = FORMAT.format({args=args_str, express=code})

	var script = GDScript.new()
	script.set_source_code(lambda_code)
	script.reload()
	var obj = Reference.new()
	obj.set_script(script)
	var ret = obj.callv('eval', args.values())
	return ret
