
output "ip_splunk" {
    value = outscale_vm.splunk.public_ip
}

output "splunk_url" {
  description = "URL to access the Splunk instance"
   value      = "http://${outscale_vm.splunk.public_ip}:8000"
}
