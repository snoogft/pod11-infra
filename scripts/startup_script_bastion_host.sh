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
# Installing Cloud SQL proxy
sudo wget https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64 -O cloud_sql_proxy -P /usr/local/bin
chmod +x /usr/local/bin/cloud_sql_proxy
# Installing PostgreSql
sudo yum install -y postgresql
# Create connection to db by proxy
cat <<EOF > /etc/systemd/system/cloud-sql-proxy.service
[Unit]
Description=Connecting MySQL Client from Compute Engine using the Cloud SQL Proxy
Documentation=https://cloud.google.com/sql/docs/mysql/connect-compute-engine
Requires=networking.service
After=networking.service

[Service]
WorkingDirectory=/usr/local/bin
ExecStart=/usr/local/bin/cloud_sql_proxy -dir=/var/run/cloud-sql-proxy -instances=${instance_connection_name}=tcp:5432
Restart=always
StandardOutput=journal
User=root

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl start cloud-sql-proxy
#Create db
createdb -h localhost -p 5432 -U account_user account_db
createdb -h localhost -p 5432 -U ledger_user ledger_db