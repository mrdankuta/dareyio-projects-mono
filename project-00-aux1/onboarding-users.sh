#!/bin/bash

userfile=$(cat names.csv)
PASSWORD=devpass

if [ $(id -u) -eq 0 ]; then
    for user in $userfile;
        do 
            echo $user
        if id "$user" &>/dev/null
            then
                echo "User Exists"
        else
            useradd -m -d /home/$user -s /bin/bash -g developers $user
            echo "$user created as user"
            echo

            su - -c "mkdir ~/.ssh" $user
            echo ".ssh directory created for $user"
            echo

            su - -c "chmod 700 ~/.ssh" $user
            echo "user permission set for .ssh directory"
            echo

            su - -c "touch ~/.ssh/authorized_keys" $user
            echo "Authorized Key File Created"
            echo

            su - -c "chmod 600 ~/.ssh/authorized_keys" $user
            echo "user permission set for the Authorized Key File"
            echo

            cp -R "/home/ubuntu/Shell/id_rsa.pub" "/home/$user/.ssh/authorized_keys"
            echo "Copied the Public Key to $user account on server"
            echo
            echo

            echo "USER CREATED"

            sudo echo -e "$PASSWORD\n$PASSWORD" | sudo passwd "$user"
            sudo passwd -x 5 $user
        fi
    done
else
    echo "This action is above your paygrade."
fi