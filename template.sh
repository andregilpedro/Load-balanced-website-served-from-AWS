#!/bin/bash
sudo su
yum update -y
yum install -y httpd
TOKEN=`curl -sX PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"`
PRIVATE_IP=`curl -sH "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/local-ipv4`
systemctl start httpd.service
systemctl enable httpd.service
echo "$PRIVATE_IP" > /var/www/html/index.html