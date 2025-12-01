
##############################################################################################################
#Security Group Net1 Vlan 1
# IN : icmp, SSH
# OUT: icmp, SSH,oversec UDP, iperf, HTTP,HTTPS,FTP
##############################################################################################################
resource "outscale_security_group" "splunk_net_sn1_sg" {
	description = "Sec group splunk bastion net sn1"
	security_group_name = "splunk_net_sn1_sg"
	net_id =outscale_net.splunk_net.net_id
}

################################
#   IN
################################
resource "outscale_security_group_rule" "splunk_net_sn1_SSH_in" {
	flow = "Inbound"
	security_group_id = outscale_security_group.splunk_net_sn1_sg.security_group_id
	from_port_range = "22"
	to_port_range = "22"
	ip_protocol = "tcp"
	ip_range = "0.0.0.0/0" #Replace with your own IP
}

resource "outscale_security_group_rule" "splunk_net_sn1_http_splunk" {
	flow = "Inbound"
	security_group_id = outscale_security_group.splunk_net_sn1_sg.security_group_id
	from_port_range = "8000"
	to_port_range = "8000"
	ip_protocol = "tcp"
	ip_range = "0.0.0.0/0" #Replace with your own IP
}
