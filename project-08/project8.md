# Project 8 - Load Balancer Solution With Apache

*Continuation of [Project 7](https://github.com/mrdankuta/pbl-project-7)*

---

## Step 1 - Setup Apache2 Load Balancer Server

- In EC2 launch new Ubuntu server named `apache-lb`
- Open TCP port 80 for HTTP access
- Install Apache webserver software:
    ```
    sudo apt update
    sudo apt install apache2 -y
    sudo apt-get install libxml2-dev -y
    ```
- Enable modules for load balancing:
    ```
    sudo a2enmod rewrite proxy proxy_balancer proxy_http headers lbmethod_bytraffic 
    ```
- Restart apache to activate the new configuration:
    ```
    sudo systemctl restart apache2
    ```
- Configure load balancer and add member webservers by editing the `000-default.conf` file:
    ```
    sudo vi /etc/apache2/sites-available/000-default.conf
    ```
- Insert the following code between `<VirtualHost *:80>` and `</VirtualHost>` and add the private IPs of your webservers:
    ```
    <Proxy "balancer://mycluster">
        BalancerMember http://<WebServer1-Private-IP-Address>:80 loadfactor=5 timeout=1
        BalancerMember http://<WebServer2-Private-IP-Address>:80 loadfactor=5 timeout=1
        BalancerMember http://<WebServer2-Private-IP-Address>:80 loadfactor=5 timeout=1
        ProxySet lbmethod=bytraffic
    #	ProxySet lbmethod=byrequests
    </Proxy>
        ProxyPreserveHost On
        ProxyPass / balancer://mycluster/
        ProxyPassReverse / balancer://mycluster/
    ```
- Restart apache to activate the new configuration:
    ```
    sudo systemctl restart apache2
    ```
- Unmount each webserver's log directory from the NFS server (if mounted). On each webserver, run:
    ```
    sudo systemctl stop httpd
    sudo umount -f /var/log/httpd
    sudo vi /etc/fstab
    # Comment out the logs mount
    sudo systemctl start httpd
    sudo mount -a
    ```
- Visit `http://<apache-lb-public-ip-address>/index.php` in browser to test the load balancer
- Refresh page several times to get traffic distributed across member webservers
- To view the access logs on each member server run:
    ```
    sudo tail -f /var/log/httpd/access_log
    ```
