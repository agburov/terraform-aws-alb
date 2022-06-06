#!/usr/bin/env bash
yum install -y docker
systemctl enable docker
systemctl start docker
usermod -aG docker ec2-user
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/bin/docker-compose
chmod +x /usr/bin/docker-compose

sudo yum install -y git
git clone https://github.com/agburov/react-redux-realworld-example-app.git
cd /react-redux-realworld-example-app
docker-compose build .
docker-compose up -d
