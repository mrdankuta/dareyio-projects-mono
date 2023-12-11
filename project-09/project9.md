# Project 9 - Continous Integration Pipeline For Tooling Website

*Continuation of [Project 8](https://github.com/mrdankuta/pbl-project-8)*

---

## Install Jenkins Server

- In EC2 spin up an Ubuntu server named `jenkins`
- Install JDK:
    ```
    sudo apt update
    sudo apt install default-jdk-headless
    ```
- Install Jenkins:
    ```
    wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
    sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
    sudo apt update
    sudo apt-get install jenkins
    ```
- Verify Jenkins is active:
    ```
    sudo systemctl status jenkins
    ```
- In EC2 open TCP port `8080`
    ![Open Port 8080](images/001-open-port-8080.png)


## Configure Jenkins Server & Connect to Github Repository


- Visit `http://<jenkins-server-public-ip-address>:8080` in browser to begin Jenkins configuration
    ![jenkins Login](images/002-jenkins-login.png)
- Get Initial Admin Password from `/var/lib/jenkins/secrets/initialAdminPassword`:
    ```
    sudo cat /var/lib/jenkins/secrets/initialAdminPassword
    ```
- Login. 
- Install suggested plugins. 
- Create first admin user.
- Jenkins is ready!
    ![Jenkins Ready](images/003-jenkins-is-ready.png)
- Create new job/project. Give it a name, select `Freestyle project` and click `ok`
    ![Project Naming](images/004-jenkins-name-job.png)
- Connect jenkins project to Github repository via Webhook by adding `http://<jenkins-server-public-ip-address>:8080/github-webhook/` as the payload URL in Settings -> Webhook in Github repository
    ![Jenkins Github Webhook](images/005-jenkins-github-webhook.gif)
- In Jenkins project, under configuration -> Source Code Management, select `Git`, enter Github repository URL and credentials, save.
    ![Jenking Config](images/006-jenkins-config.png)
- Test configuration by clicking `Build Now`
    ![Jenkins Test Build](images/007-jenkins-test-build.png)
- Configure automatic triggering from Github Webhook
    ![Jenkins Auto Trigger](images/008-jenkins-github-archive.gif)
- Test automation by editing file(s) in repository and push the changes
    ![Jenkins Push Success](images/009-jenkins-push-build-success.png)


## Configure Jenkins Server to copy file to NFS server via SSH

- Install a plugin that is called ["Publish Over SSH"](https://plugins.jenkins.io/publish-over-ssh/). Dashboard -> Manage Plugins -> Goto `Available` tab -> Search for plugin -> Click `Install without restart`
    ![Install plugin](images/010-jenkins-install-plugin.png)
- Configure plugin to enable Jenkins access NFS server via SSH by adding private key and server credentials. Dashboard -> Manage Jenkins -> Configure System
    ![NFS SSH Credentials](images/011-jenkins-nfs-ssh-credentials.png)
- Return to project configuration -> Post-build Actions -> Add `Send build artifacts over SSH` -> Select NFS server connection added in previous step -> Enter `**` in Source files field to transfer all artifacts
    ![Files Over SSH Config](images/012-jenkins-project-config.png)
- Test automation by editing file(s) in repository and push the changes. If you get a `Permission Denied` error, log into NFS server and change the permissions and ownership on `/mnt/apps` :
    ```
    sudo chown -R nobody:nobody /mnt/apps
    sudo chmod -R 777 /mnt/apps
    ```
    ![Permission Problem](images/014-jenkins-permissions-problem.png)
    ![Project Success](images/015-jenkins-nfs-ssh-success.png)