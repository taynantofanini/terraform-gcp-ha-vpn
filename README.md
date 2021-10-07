# **GCP VPN HA Terraform** #

Deploy HA GCP VPN using HashiCorp Terraform

## The code deploys ##

* VPN Gateway
* VPN External (Peer) Gateway
* 2 x VPN Tunnel
* Cloud Router
* 2 x Cloud Router Interfaces
* 2 x Cloud Router Interface Peers

## **Requirements** ##

Describes requirements for using this module.

### Software ###

The following dependencies must be available:

* [Terraform](https://www.terraform.io/downloads.html)>= v0.13.5.
* [Terraform google provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs)>= v3.87.0.
* [Terraform google-beta provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs)>= v3.87.0.

### Service Account ###

* Ensure the you have a [service account](https://cloud.google.com/iam/docs/creating-managing-service-accounts) with sufficient [permissions](https://cloud.google.com/network-connectivity/docs/vpn/how-to/creating-ha-vpn#expandable-1).

### General for Module ###

* How to create a [strong pre-shared-key](https://cloud.google.com/network-connectivity/docs/vpn/how-to/generating-pre-shared-key).

## **Simple Usage** ##

1. Clone the repository:

    ```bash
    git clone https://github.com/taynantofanini/terraform-gcp-ha-vpn.git
    ```

2. Go to module folder

    ```bash
    cd terraform-gcp-ha-vpn
    ```

3. Change variable values in **terraform.tfvars** and backend path in **settings.tf** for your envrionment.

4. Run the following Terraform commands:

    1. Examine configuration files:

        ```bash
        terraform init
        terraform validate
        terraform plan
        ```

    2. Apply the configurations:

        ```bash
        terraform apply
        ```

    3. Confirm configurations:

        ```bash
        terraform output
        terraform show
        ```

    4. To destroy resources:

        ```bash
        terraform plan -destroy
        terraform destroy
        terraform show
        ```

## **Calling this module as child module** ##

```hcl
module "ha-vpn" {
  source = "github.com/taynantofanini/terraform-gcp-ha-vpn"
  #insert the required variables here
}
```

### Required Variables ###

```hcl
# General
gcp_auth_file = "auth/authfile.json" # put your auth file name
project_id    = "your-project-id"
network       = "your-network"
gcp_region    = "gcp-region"

# General VPN / Router
vpn_name         = "a-prefix-to-your-resources" # if you don't want to use, set null
ha_shared_secret = "Sh4r3Ds3cR3tSh4r3Ds3cR3tSh4r3Ds3cR3t" # instructions to generate strong pre-shared-key above
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
```

## **Author** ##

* Taynan Tofanini <taynantofanini@gmail.com>
* <https://github.com/taynantofanini/terraform-gcp-ha-vpn>
