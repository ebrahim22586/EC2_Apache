#!/bin/bash
             sudo  yum update -y
             sudo yum install -y httpd
              systemctl enable --now httpd
              echo "hi from EC2 made by Ibrahim" > /var/www/html/index.html