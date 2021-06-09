#!/bin/bash
# Install kubectl
sudo yum install -y kubectl
sudo yum install -y bash-completion
# Get credential for container
echo "gcloud container clusters get-credentials ${cluster_name} --zone=${zone}" >> /etc/bashrc
echo "source <(kubectl completion bash)" >> /etc/bashrc
# Installing the Cloud Logging agent 
curl -sSO https://dl.google.com/cloudagents/add-logging-agent-repo.sh
sudo bash add-logging-agent-repo.sh --also-install
# Installing the Cloud Monitoring agent
curl -sSO https://dl.google.com/cloudagents/add-monitoring-agent-repo.sh
sudo bash add-monitoring-agent-repo.sh --also-install
