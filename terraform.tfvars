# General
gcp_auth_file = "auth/authfile.json"
project_id    = "your-project-id"
network       = "your-network"
gcp_region    = "gcp-region"

# General VPN / Router
vpn_name         = "a-prefix-to-your-resources" # if you don't want to use, set null
ha_shared_secret = "Sh4r3Ds3cR3tSh4r3Ds3cR3tSh4r3Ds3cR3t"
ha_router_asn    = "65020"
ha_peer_asn      = "65030"

# Tunnel 1
peer_ip_1                     = "35.222.111.131"
ha_router_interface1_ip_range = "169.254.1.1/30"
ha_router_peer1_ip_address    = "169.254.1.2"

# Tunnel 2
peer_ip_2                     = "35.222.111.132"
ha_router_interface2_ip_range = "169.254.50.1/30"
ha_router_peer2_ip_address    = "169.254.50.2"
