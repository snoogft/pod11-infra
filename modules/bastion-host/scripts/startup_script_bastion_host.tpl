#!/bin/bash
logger "Startup script for bastion host starting..."
# Install kubectl
sudo apt-get install -y kubectl
sudo apt-get install -y bash-completion
# Install nomos
gcloud components install nomos
# Get credential for container
echo "gcloud container clusters get-credentials ${cluster_name} --zone=${zone}" >> /etc/bash.bashrc
echo "source <(kubectl completion bash)" >> /etc/bash.bashrc
# Installing the Cloud Logging agent 
curl -sSO https://dl.google.com/cloudagents/add-logging-agent-repo.sh
sudo bash add-logging-agent-repo.sh --also-install
# Installing the Cloud Monitoring agent
curl -sSO https://dl.google.com/cloudagents/add-monitoring-agent-repo.sh
sudo bash add-monitoring-agent-repo.sh --also-install
logger "Startup script for bastion host completed"
