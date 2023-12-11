# Auxiliary Project 1 - Shell Scripting

- Create file named `names.csv` and populate with first names of users to be onboarded by editing with a text editor and inserting one name per line.
- Create a shell script named `onboarding-users.sh` and have it do the following:
    ```
    -----------------------------------------------------

    # Read a CSV file that contains 20 new Linux users.
    # Create each user on the server and add to an existing group called 'Developers'.
    # Check for the existence of the user on the system, before attempting to create new user.
    # The user that is being created also must also have a default home folder
    # Each user should have a .ssh folder within its HOME folder. If it does not exist, then it will be created.
    # For each user’s SSH configuration, create an authorized_keys file and add the public key provided for project.

    ----------------------------------------------------
    ```
- Create ec2 instance
- Copy `onboarding-users.sh` and `names.csv` to server
    ```
    scp -i private_key.pem onboarding-users.sh user@ip-address:~/;
    scp -i private_key.pem names.csv user@ip-address:~/;
    ```
- Make directory named `Shell` in home directory
    ```
    mkdir Shell
    ```
- Move `onboarding-users.sh` and `names.csv` into `Shell` directory
    ```
    mv onboarding-users.sh Shell
    mv names.csv Shell
    ```
- Navigate into `Shell` directory
    ```
    cd Shell
    ```
- Create and edit file for public key to be used by new users:
    ```
    vi id_rsa.pub
    ```
- Insert the public key provided for project.
- Create and edit file for private key to be used by new users:
    ```
    vi id_rsa
    ```
- Insert the private key provided for project.
- Create user group in which new users are to be added:
    ```
    sudo groupadd developers
    ```
- Add an executable permission to the `onboarding-users.sh` file:
    ```
    sudo chmod +x onboarding-users.sh
    ```
- Switch current user to `root`;
    ```
    sudo su
    ```
- Execute `onboarding-users.sh`
    ```
    ./onboarding-users.sh
    ```
    ![Onboarding Users](./images/001-onboarding-users.gif)
- Test operation by connecting to server via ssh with any onboarded user
    ![Testing Onboarded Users](./images/002-testing-onboarded-users.gif)