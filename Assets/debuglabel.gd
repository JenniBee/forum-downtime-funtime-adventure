extends Label

var bgZ
var masksZ
var mask_chairZ
var lightsZ
var canvasModZ
var mask_chairZmin
var mask_chairZmax


func _ready():
	set_process(true)

func _process(delta):
	bgZ = str( get_parent().get_z() )
	masksZ = str( get_parent().get_node("Masks").get_z() )
	mask_chairZ = str( get_parent().get_node("Masks/mask_chair").get_z() )
	lightsZ = str( get_parent().get_node("Lights").get_z() )
	mask_chairZmin = str( get_parent().get_node("Masks/mask_chair").get_z_range_min() )
	mask_chairZmax = str( get_parent().get_node("Masks/mask_chair").get_z_range_max() )
	set_text("bgZ "+bgZ+"\nmasksZ "+masksZ+"\nmask_chairZ "+mask_chairZ+" "+mask_chairZmin+ " "+ mask_chairZmax + "\nlightsZ "+lightsZ)