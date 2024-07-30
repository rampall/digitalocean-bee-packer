#!/bin/bash

# Install nvm, node, swarm-cli
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
nvm install 20
npm install --global @ethersphere/swarm-cli

# Install Bee
curl -fsSL https://repo.ethswarm.org/apt/gpg.key | sudo gpg --dearmor -o /usr/share/keyrings/ethersphere-apt-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ethersphere-apt-keyring.gpg] https://repo.ethswarm.org/apt \
  * *" | sudo tee /etc/apt/sources.list.d/ethersphere.list > /dev/null
apt-get update -y
while lsof /var/lib/dpkg/lock-frontend ; do sleep 1; done;
apt-get install bee -y

# Copy Bee configuration file
mkdir -p /etc/bee
npx bee-yaml > /etc/bee/bee.yaml
systemctl restart bee.service
systemctl enable bee.service

# Cleanup
apt-get purge droplet-agent -y
rm -rf /opt/digitalocean