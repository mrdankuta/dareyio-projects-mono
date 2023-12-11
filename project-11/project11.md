# Project 11 - Ansible – Automate Project 7 to 10


---

## Step 1 - Install & Configure Ansible
- Rename `jenkins` server name tag from previous projects to `jenkins-ansible` in EC2 and SSH into server.
- Install `Ansible`:
  ```
  sudo apt update
  sudo apt install ansible
  ```
- Check `ansible` version to confirm installation: 
  ```
  ansible --version
  ```
  ![Ansible Installed](images/001-ansible-install.png)

  ## Step 2 - Configure Jenkins Server to copy file to NFS server via SSH

- Goto Jenkins Dashboard `http://<jenkins-server-public-ip-address>:8080` in browser to begin Jenkins configuration
- Create new job/project. Give it a name `ansible`, select `Freestyle project` and click `ok`
    ![Project Naming](images/002-jenkins-setup-1.png)
- Connect jenkins project to Github repository via Webhook by adding `http://<jenkins-server-public-ip-address>:8080/github-webhook/` as the payload URL in Settings -> Webhook in Github repository
    ![Jenkins Github Webhook](images/003-jenkins-github-webhook.png)
- In Jenkins project, under configuration -> Source Code Management, select `Git`, enter Github repository URL and credentials, save.
    ![Jenking Config](images/004-jenkins-config-git.png)
- Configure automatic triggering from Github Webhook
    ![Jenkins Auto Trigger](images/005-1-jenkins-trigger.png)
- Configure all build files to be archived
  ![Jenkins Build Archive](images/005-jenkins-archive-artifacts.png)
- Goto project configuration -> Post-build Actions -> Add `Send build artifacts over SSH` -> Select NFS server connection added in previous step -> Enter `**` in Source files field to transfer all artifacts
    ![Files Over SSH Config](images/006-jenkins-artifacts-ssh.png)
- Test automation by editing file(s) in repository and push the changes.
  ![Push Build Success](images/007-jenkins-push-build.png)