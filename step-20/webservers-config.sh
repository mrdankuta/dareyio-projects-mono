#!/bin/bash

# debug mode - enables debug output
set -x

# exit the script if there is an error - stops the script if any command fails
set -e

# exit the script when there is a pipe failure - stops the script if any part of a pipe fails
set -o pipefail

# get the public IP passed as an argument
PUBLIC_IP=$1

# check if public IP is empty, print message and exit if so
[ -z "${PUBLIC_IP}" ] && echo "Please pass the public IP of your virtual machine as an argument to the script" && exit 1

# update packages and install apache
sudo apt update -y &&  sudo apt install apache2 -y

# check apache status
sudo systemctl status apache2

if [[ $? -eq 0 ]]; then # if apache is running
    # set permissions to change ports.conf
    sudo chmod 777 /etc/apache2/ports.conf

    # change listen port to 8000
    echo "Listen 8000" >> /etc/apache2/ports.conf

    # set permissions to change apache config
    sudo chmod 777 -R /etc/apache2/

    # change virtual host port to 8000
    sudo sed -i 's/<VirtualHost \*:80>/<VirtualHost *:8000>/' /etc/apache2/sites-available/000-default.conf
fi

# set permissions on web root folder
sudo chmod 777 -R /var/www/
echo "<!DOCTYPE html> # print HTML content
        <html>
        <head>
            <title>My Auto LoadBalancer Project</title> 
        </head>
        <body>
            <h1>Welcome to my Auto LoadBalancer Project</h1>
            <p>Public IP: "${PUBLIC_IP}"</p> # print public IP 
        </body>
        </html>" > /var/www/html/index.html # save content to index.html

# restart apache
sudo systemctl restart apache2
