#!/usr/bin/env bash

set -o pipefail
set -o nounset
set -o errexit

function warn {
	if ! eval "$@"; then
		echo >&2 "WARNING: command failed \"$@\""
	fi
}

echo "Install ansible2"
warn "sudo amazon-linux-extras install -y ansible2"

echo "Install other tools"
warn "sudo yum install -y iptables-services net-tools"

echo "Enable IPtables"
warn "sudo systemctl enable iptables"
warn "sudo systemctl start iptables"

echo 'Downloading and installing SSM Agent' 
warn "sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm"

echo 'Check SSM agent is running' 
warn "sudo systemctl status amazon-ssm-agent"

echo 'Downloading and installing amazon-cloudwatch-agent'
warn "sudo yum install -y https://s3.amazonaws.com/amazoncloudwatch-agent/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm"

echo 'Starting cloudwatch agent'
warn "sudo amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/tmp/CWAgentParameters.json -s"

echo 'Install Amazon Inspector'
warn 'curl https://inspector-agent.amazonaws.com/linux/latest/install | sudo bash -x'

#sudo yum update -y kernel
#sudo reboot
