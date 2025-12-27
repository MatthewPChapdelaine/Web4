extends Node

var mycelial_net = {}  # Dictionary simulating graph: {user_id: {connections: [], resources: []}}

@onready var xr_origin = $XROrigin3D
@onready var xr_camera = $XROrigin3D/XRCamera3D
@onready var left_controller = $XROrigin3D/XRControllerLeft
@onready var right_controller = $XROrigin3D/XRControllerRight

func _ready():
    # Initialize XR
    if XRServer.find_interface("OpenXR"):
        var xr_interface = XRServer.find_interface("OpenXR")
        if xr_interface and xr_interface.initialize():
            get_viewport().use_xr = true
            print("XR initialized successfully")
        else:
            print("Failed to initialize XR")

    add_user(1, "Innovator")
    add_user(2, "Guardian")
    connect_users(1, 2)

func add_user(id: int, archetype: String):
    mycelial_net[id] = { "archetype": archetype, "connections": [], "resources": [] }

func connect_users(a: int, b: int):
    mycelial_net[a]["connections"].append(b)
    mycelial_net[b]["connections"].append(a)

func llm_navigate(pilot_npc: String, from_id: int, to_id: int):
    # Simulate LLM decision: Check compatibility
    if mycelial_net[from_id]["archetype"] == mycelial_net[to_id]["archetype"]:
        print(pilot_npc + " approves symbiotic jump!")
        # Trigger visual effect: Animate spore burst in VR
        spawn_spore_burst()
    else:
        print(pilot_npc + " signals warning: Incompatible nodes!")

func spawn_spore_burst():
    # Simple VR effect: Could instantiate particles or models
    print("Spore burst effect triggered in VR")

func _process(delta):
    # Handle VR controller inputs
    if left_controller.is_button_pressed("trigger"):
        llm_navigate("Azazel", 1, 2)
    if right_controller.is_button_pressed("grip"):
        print("Grip pressed: Dig tubeway")