


locals {
  trigger = join("-", ["JTT", formatdate("YYYYMMDDhhmmss", timestamp())])
  packer_init_splunk = terraform_data.packer_init_splunk.output
  omi_delete = terraform_data.packer_build_splunk.output
  keypair_name = "kp-splunk"
}

#############################################################################################################################
#
# Keypair
#
#############################################################################################################################

resource "tls_private_key" "kp-splunk" {
  algorithm = "RSA"
  rsa_bits  = "2048"
}

resource "local_file" "kp-splunk" {
  filename        = "${path.module}/kp-splunk.pem"
  content         = tls_private_key.kp-splunk.private_key_pem
  file_permission = "0600"
}

resource "outscale_keypair" "kp-splunk" {
  keypair_name = "kp-splunk"
  public_key = tls_private_key.kp-splunk.public_key_openssh
}


#############################################################################################################################
#
# Lancement de Packer splunk
#
#############################################################################################################################


resource "terraform_data" "packer_init_splunk" {
  input =  local.trigger

  provisioner "local-exec" {
    working_dir = "./"
    command = "packer init vm_splunk.hcl" 
  }
}


resource "terraform_data" "packer_build_splunk" {
  input = local.packer_init_splunk
  
  provisioner "local-exec" {
    working_dir = "./"
    environment = {
    OUTSCALE_ACCESSKEYID = "${var.access_key_id}"
    OUTSCALE_SECRETKEYID = "${var.secret_key_id}"

    }
    command = "packer build vm_splunk.hcl" 
  
  }
}


data "outscale_images" "splunk" {
  filter {
   name = "image_names"
   values = ["*splunk*"]
  }
  depends_on = [
    terraform_data.packer_build_splunk
  ]
}

#############################################################################################################################
#
# VM NET1 = Serveur splunk
#
#############################################################################################################################

resource "outscale_vm" "splunk" {
    image_id  = tolist(data.outscale_images.splunk.images)[0].image_id
    vm_type                  = "tinav7.c4r8p2"
    keypair_name             = "kp-splunk"
    subnet_id = outscale_subnet.splunk_net_sn1.subnet_id
    security_group_ids = [outscale_security_group.splunk_net_sn1_sg.security_group_id]
    tags {
        key   = "name"
        value = "splunk-server"
    }
    user_data                = base64encode(<<EOF
    <CONFIGURATION>
    EOF
    )
}

resource "outscale_public_ip" "splunk_pub_ip"{
	tags {
	key="Name"
	value="IP_splunk"
  }
}



resource "outscale_public_ip_link" "public_ip_link_splunk" {
    vm_id     = outscale_vm.splunk.vm_id
    public_ip = outscale_public_ip.splunk_pub_ip.public_ip
}
