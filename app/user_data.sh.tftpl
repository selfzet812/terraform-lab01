#!/bin/bash
dnf install -y httpd

TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 300")
PRIVATE_IP=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/local-ipv4)
AZ=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/placement/availability-zone)

cat > /var/www/html/index.html <<EOF
<h1>lab01</h1>
<p>Environment: ${env}</p>
<p>Owner: ${owner}</p>
<p>Private IP: $PRIVATE_IP</p>
<p>AZ: $AZ</p>
EOF

systemctl enable --now httpd