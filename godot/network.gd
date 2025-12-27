extends Node

# Multiplayer Networking for Tunnel Tubeways
@onready var multiplayer_peer = ENetMultiplayerPeer.new()

func _ready():
    # Initialize multiplayer
    multiplayer_peer.create_server(4242)
    multiplayer.multiplayer_peer = multiplayer_peer
    multiplayer.peer_connected.connect(_on_peer_connected)

func _on_peer_connected(id):
    print("Peer connected: ", id)
    # Sync mycelial_net state

@rpc("any_peer", "call_local")
func sync_tubeway(from_id: int, to_id: int):
    # Sync tubeway digging across network
    connect_users(from_id, to_id)