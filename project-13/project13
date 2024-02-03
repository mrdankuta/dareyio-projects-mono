# Project 13 - Ansible Dynamic Assignments (Include) and Community Roles

*Final code can be found here: <https://github.com/mrdankuta/ansible-config-mgt>*

This project extends project 12 by adding dynamic assignments to our Ansible configuration management. We introduce dynamic assignments using the include module, contrasting with static assignments via the import module. Static assignments pre-process all statements when playbooks are parsed, meaning subsequent changes won't apply. Dynamic assignments process statements only during playbook execution, incorporating subsequent changes. Static assignments are typically more reliable for playbooks while dynamic assignments allow environment-specific variables.

---

## INCORPORATING DYNAMIC ASSIGNMENT INTO OUR STRUCTURE

- In our `ansible-config-mgt` repo, checkout the `main` branch and form a new branch called `dynamic-assignments`.  

```sh
git checkout -b dynamic-assignments
```

- Create a new directory called `dynamic-assignments`.
- Create a new file called `env-vars.yml`. We will include it in `site.yml` later.

*We will be utilizing Ansible to configure multiple environments and each of these environments will have certain unique attributes, such as servername and ip-address etc. We will assign values to variables per specific environment.*

- Create a new directory `env-vars`, then for each environment generate new YAML files which we will employ to assign variables.  

- Paste this snippet below into the `env-vars.yml` file.  

```yml
---
- name: collate variables from env specific file, if it exists
  hosts: all
  tasks:
    - name: looping through list of available files
      include_vars: "{{ item }}"
      with_first_found:
        - files:
            - dev.yml
            - stage.yml
            - prod.yml
            - uat.yml
          paths:
            - "{{ playbook_dir }}/../env-vars"
      tags:
        - always
```

### UPDATE SITE.YML WITH DYNAMIC ASSIGNMENTS

- Update `site.yml` file to utilize the dynamic assignment with the snippet below:  

```yml
---
- hosts: all
- name: Include dynamic variables
  tasks:
    import_playbook: ../static-assignments/common.yml
    include: ../dynamic-assignments/env-vars.yml
  tags:
    - always

- hosts: webservers 
  name: Webserver assignment
    import_playbook: ../static-assignments/webservers.yml
```

### DOWNLOAD MYSQL ANSIBLE ROLE

*Next, we will create a role for MySQL database to install the MySQL package, create a database and configure users. There are numerous roles that have already been developed by other open source engineers accessible. We can simply download a ready to utilize ansible role from the community [here](https://galaxy.ansible.com/home).*

- Download [MySQL role](https://galaxy.ansible.com/geerlingguy/mysql) developed by **geerlingguy**.

- Navigate into the `roles` directory  

```sh
cd roles
```

- Generate the `Mysql` role  

```sh
ansible-galaxy init geerlingguy.mysql
```

- Rename the `Mysql` role  

```sh
mv geerlinguy.mysql/ mysql
```  

- Read through the `README.md` file in role and follow the instructions to edit the role configurations.  

- Edit the `defaults/main.yml` in the `Mysql` role  

- Create a `db.yml` file in the `static_assignment` directory that will point to the `Mysql` role  

- Commit, push and merge the `roles-feature` branch to `main` branch.  

### LOAD BALANCER ROLES

*Our goal here is to be able to choose which Load Balancer to utilize, `Nginx` or `Apache`, so we need to have two roles respectively:*

- Nginx
- Apache

- Create roles for `Nginx` and `Apache` from the community. Install the roles in the `roles` directory.

```sh
ansible-galaxy install geerlingguy.nginx
```  

```sh
ansible-galaxy install geerlingguy.apache
```  

- Rename `roles` to `Nginx` and `Apache` respectively.  

```sh
mv geerlingguy.nginx/ nginx
mv geerlingguy.apache/ apache
```

- Create a condition to enable either `Nginx` or `Apache` by using variables. In `defaults/main.yml` file inside the `Nginx` and `Apache` roles, declare a variable and name each variables `enable_nginx_lb` and `enable_apache_lb` respectively and set both variables to `false`.  

- Declare another variable in both roles `load_balancer_is_required` and set its value to `false`.  

- Edit the `defaults/main.yml` files  

```yml
# For nginx  
enable_nginx_lb: false  
load_balancer_is_required: false

# For apache  
enable_apache_lb: false
load_balancer_is_required: false  
```

- In the `static_assignments` directory, create a file `loadbalancers.yml` file and insert the following code:  

```yml
- hosts: lb
  roles:
    - { role: nginx, when: enable_nginx_lb and load_balancer_is_required }
    - { role: apache, when: enable_apache_lb and load_balancer_is_required }  
```

- Then update the `playbooks/sites.yml` file with the following code:

```yml
- name: Loadbalancers assignment
    - import_playbook: ../static-assignments/loadbalancers.yml
      when: load_balancer_is_required
```  

- Now use `env-vars\uat.yml` to define which loadbalancer to utilize in UAT environment by assigning respective environmental variable to true.
