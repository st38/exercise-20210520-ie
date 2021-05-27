# Errbit

 This cookbook installs and configure Errbit on Ubuntu and Debian operating system


# Usage

 1. Get cookbook from the GitHub
    ```bash
    git clone https://github.com/st38/exercise-20210520-ie.git
    ```

 2. Change Errbit configuration in `attributes/default.rb` if required

 3. Run cookbook on the remote node
    ```bash
    cd exercise-20210520-ie
    
    # Change variables
    user=ubuntu
    host=ec2-18-184-242-99.eu-central-1.compute.amazonaws.com
    cookbook=errbit
    key=id_rsa

    chef-run ssh://$user@$host $cookbook --identity-file ~/.ssh/$key
    ```
