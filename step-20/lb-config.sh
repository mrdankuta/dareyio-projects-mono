#!/bin/bash

# Public IP passed as first argument
PUBLIC_IP=$1

# First webserver IP and port passed as second argument
firstWebserver=$2 

# Second webserver IP and port passed as third argument
secondWebserver=$3

# Check if Public IP argument is empty
[ -z "${PUBLIC_IP}" ] && echo "Please pass the Public IP of your virtual machine as the argument to the script" && exit 1

# Check if first webserver argument is empty
[ -z "${firstWebserver}" ] && echo "Please pass the Public IP together with its port number in this format: 127.0.0.1:8000 as the second argument to the script" && exit 1

# Check if second webserver argument is empty 
[ -z "${secondWebserver}" ] && echo "Please pass the Public IP together with its port number in this format: 127.0.0.1:8000 as the third argument to the script" && exit 1 

# Enable debug mode
set -x

# Exit script if any command fails
set -e

# Exit script if any part of pipe fails
set -o pipefail


# Update packages and install nginx
sudo apt update -y && sudo apt install nginx -y

# Check nginx status
sudo systemctl status nginx

if [[ $? -eq 0 ]]; then # If nginx installed successfully
    # Create load balancer config file
    sudo touch /etc/nginx/conf.d/loadbalancer.conf

    # Set permissions on config file
    sudo chmod 777 /etc/nginx/conf.d/loadbalancer.conf

    # Set permissions on nginx directory
    sudo chmod 777 -R /etc/nginx/

    # Define upstream block for backend servers
    echo " upstream backend_servers {
                server  "${firstWebserver}"; # public IP and port for webserser 1 
                server "${secondWebserver}"; # public IP and port for webserver 2
            }

            server {
                listen 80; # Listen on port 80
                server_name "${PUBLIC_IP}"; # Set server name to Public IP

                location / {
                    proxy_pass http://backend_servers; # Proxy requests to backend servers  
                } 
            } " > /etc/nginx/conf.d/loadbalancer.conf # Save config file
fi 

# Test nginx config
sudo nginx -t

# Restart nginx
sudo systemctl restart nginx


upstream backend_servers {
    server ${firstWebserver}; # public IP and port for webserver 1
    server ${secondWebserver}; # public IP and port for webserver 2  
}

server {
    listen 80; 
    server_name ${PUBLIC_IP};

    location / {
        proxy_pass http://backend_servers;
    }
}

