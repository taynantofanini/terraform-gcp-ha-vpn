variable "project_id" {
  description = "GCP project ID"
  type        = string
}
variable "gcp_auth_file" {
  description = "GCP authentication file"
}
variable "gcp_region" {
  type        = string
  description = "GCP region"
}
variable "network" {
  type        = string
  description = "GCP network"
}
variable "peer_ip_1" {
  type        = string
  description = "Peer gateway IP 1"
}
variable "peer_ip_2" {
  type        = string
  description = "Peer gateway IP 2"
}
variable "ha_router_asn" {
  description = "ASN for local side of BGP sessions"
  type        = string
  default     = "64514"
}
variable "ha_peer_asn" {
  description = "ASN for local side of BGP sessions"
  type        = string
  default     = "64515"
}
variable "ha_shared_secret" {
  description = "Tunnel shared secret"
  type        = string
}
variable "ha_router_interface1_ip_range" {
  description = "Router Interface #1 IP Range"
  type        = string
}
variable "ha_router_interface2_ip_range" {
  description = "Router Interface #2 IP Range"
  type        = string
}
variable "ha_router_peer1_ip_address" {
  description = "Router Peer #1 IP Address"
  type        = string
}
variable "ha_router_peer2_ip_address" {
  description = "Router Peer #1 IP Address"
  type        = string
}
variable "vpn_name" {
  type    = string
  default = null
}
