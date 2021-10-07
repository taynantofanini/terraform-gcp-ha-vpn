# VPN Gateway
resource "google_compute_ha_vpn_gateway" "vpn-gateway-ha" {
  provider = google-beta
  region   = var.gcp_region
  name     = var.vpn_name == null ? "vpn-gateway-ha" : "${var.vpn_name}-vpn-gateway-ha"
  network  = var.network
}
# VPN Peer Gateway

resource "google_compute_external_vpn_gateway" "vpn-peer-gateway-ha" {
  provider        = google-beta
  name            = var.vpn_name == null ? "peer-vpn-gateway-ha" : "${var.vpn_name}-peer-vpn-gateway-ha"
  redundancy_type = "TWO_IPS_REDUNDANCY"

  interface {
    id         = 0
    ip_address = var.peer_ip_1
  }
  interface {
    id         = 1
    ip_address = var.peer_ip_2
  }
}

# VPN Tunnel 1
resource "google_compute_vpn_tunnel" "vpn-tunnel1-ha" {
  provider                        = google-beta
  name                            = var.vpn_name == null ? "vpn-tunnel1-ha" : "${var.vpn_name}-vpn-tunnel1-ha"
  region                          = var.gcp_region
  vpn_gateway                     = google_compute_ha_vpn_gateway.vpn-gateway-ha.id
  peer_external_gateway           = google_compute_external_vpn_gateway.vpn-peer-gateway-ha.id
  peer_external_gateway_interface = 0
  shared_secret                   = var.ha_shared_secret
  router                          = google_compute_router.vpn-router-ha.id
  vpn_gateway_interface           = 0
}
# VPN Tunnel 2
resource "google_compute_vpn_tunnel" "vpn-tunnel2-ha" {
  provider                        = google-beta
  name                            = var.vpn_name == null ? "vpn-tunnel2-ha" : "${var.vpn_name}-vpn-tunnel2-ha"
  region                          = var.gcp_region
  vpn_gateway                     = google_compute_ha_vpn_gateway.vpn-gateway-ha.id
  peer_external_gateway           = google_compute_external_vpn_gateway.vpn-peer-gateway-ha.id
  peer_external_gateway_interface = 1
  shared_secret                   = var.ha_shared_secret
  router                          = google_compute_router.vpn-router-ha.id
  vpn_gateway_interface           = 1
}

# Cloud Router
resource "google_compute_router" "vpn-router-ha" {
  name    = var.vpn_name == null ? "cloud-router-ha" : "${var.vpn_name}-cloud-router-ha"
  network = var.network
  region  = var.gcp_region
  bgp {
    asn = var.ha_router_asn
  }
}

# Cloud Router Interface 1
resource "google_compute_router_interface" "vpn-router-interface1-ha" {
  depends_on = [google_compute_router.vpn-router-ha]
  provider   = google-beta
  name       = var.vpn_name == null ? "cloud-router-interface1-ha" : "${var.vpn_name}-cloud-router-interface1-ha"
  router     = google_compute_router.vpn-router-ha.name
  region     = var.gcp_region
  ip_range   = var.ha_router_interface1_ip_range
  vpn_tunnel = google_compute_vpn_tunnel.vpn-tunnel1-ha.name
}

# Cloud Router Peer 1 # BGP Session
resource "google_compute_router_peer" "vpn-router-peer1-ha" {
  depends_on                = [google_compute_router.vpn-router-ha]
  provider                  = google-beta
  name                      = var.vpn_name == null ? "cloud-router-peer1-ha" : "${var.vpn_name}-cloud-router-peer1-ha"
  router                    = google_compute_router.vpn-router-ha.name
  region                    = var.gcp_region
  peer_ip_address           = var.ha_router_peer1_ip_address
  peer_asn                  = var.ha_peer_asn
  advertised_route_priority = 100
  interface                 = google_compute_router_interface.vpn-router-interface1-ha.name
}

# Cloud Router Interface 2
resource "google_compute_router_interface" "vpn-router-interface2-ha" {
  depends_on = [google_compute_router.vpn-router-ha]
  provider   = google-beta
  name       = var.vpn_name == null ? "cloud-router-interface2-ha" : "${var.vpn_name}-cloud-router-interface2-ha"
  router     = google_compute_router.vpn-router-ha.name
  region     = var.gcp_region
  ip_range   = var.ha_router_interface2_ip_range
  vpn_tunnel = google_compute_vpn_tunnel.vpn-tunnel2-ha.name
}

# Cloud Router Peer 2 # BGP Session
resource "google_compute_router_peer" "vpn-router-peer2-ha" {
  depends_on                = [google_compute_router.vpn-router-ha]
  provider                  = google-beta
  name                      = var.vpn_name == null ? "cloud-router-peer2-ha" : "${var.vpn_name}-cloud-router-peer2-ha"
  router                    = google_compute_router.vpn-router-ha.name
  region                    = var.gcp_region
  peer_ip_address           = var.ha_router_peer2_ip_address
  peer_asn                  = var.ha_peer_asn
  advertised_route_priority = 100
  interface                 = google_compute_router_interface.vpn-router-interface2-ha.name
}
