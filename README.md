# **GCP VPN HA Terraform** #

Deploy HA GCP VPN using HashiCorp Terraform

## **The code deploys** ##

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

3. Change variable values in **terraform.tfvars** and backend path in __provider.tf__ for your envrionment.

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

    3. Examine configuration files:

        ```bash
        terraform init
        terraform validate
        terraform plan
        ```

    4. Confirm configurations:

        ```bash
        terraform output
        terraform show
        ```

    5. To destroy resources:

        ```bash
        terraform plan -destroy
        terraform destroy
        terraform show
        ```

## **Calling module** ##

```hcl
module "ha-vpn" {
  source = "github.com/taynantofanini/terraform-gcp-ha-vpn"
  #insert the required variables here
}
```

## **Author** ##

* Taynan Tofanini <taynantofanini@gmail.com>
* <https://github.com/taynantofanini/terraform-gcp-ha-vpn>
