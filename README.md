# Setup Errbit using Chef

 1. [Goals](#goals)
 2. [Description](#description)
 3. [System requirements](#system-requirements)
 4. [Test Chef cookbook](#test-chef-cookbook)
 5. [To do](#to-do)


# Goals
 Prepare a Chef cookbook for Errbit installation.


# Description

 We should create a [Chef](https://github.com/chef/chef) cookbook to install [Errbit](https://github.com/errbit/errbit). For local testing we may use Vagrant/Test Kitchen.

 Considerences:
   - Errbit will be running on the same host along with all its services and dependencies.
   - Run Chef on a single host to prepare everything. Compatible platforms Debian & Ubuntu.
   - Errbit should be run as SystemD service and autostarted on system boot. Host and port Errbit listens to should be configurable with node attributes
   - At least open port presence and required system services status (enabled, started) will be tested


# System requirements

 1. [Chef Workstation installed](https://downloads.chef.io/tools/workstation)
 2. [Test Kitchen Driver for Amazon EC2 installed](https://github.com/test-kitchen/kitchen-ec2)
 3. [AWS CLI installed](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) and [configured](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html#cli-configure-files-methods)
 4. AWS credentials with programatic EC2 full acess


## Test Chef cookbook

 1. Make sure that gem for kitchen-ec2 support is installed
    ```bash
    gem list | grep ec2
    ```

 2. Make sure that [AWS CLI is installed](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) and [configured](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html#cli-configure-files-methods)
    ```bash
    aws configure list
    ```

 3. Get Chef cookbook from GitHub
    ```bash
    git clone https://github.com/st38/exercise-20210520-ie.git
    ```

 4. Run Test Kitchen
    ```bash
    cd exercise-20210520-ie/errbit
    kitchen test
    ```


# To do

 1. Solve the issue with Ruby via RVM installation and PATH
 2. Consider to prepare a [Test Kitchen](https://docs.chef.io/workstation/kitchen/) config for [Vagrant](https://github.com/test-kitchen/kitchen-vagrant)
 3. Consider to use [Vagrant](https://www.vagrantup.com/) on [Mac with Apple silicon](https://support.apple.com/en-us/HT211814) using QEMU/libvirt
