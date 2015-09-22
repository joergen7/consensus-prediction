# consensus-prediction
A consensus prediction workflow for MS data

## Initialize test machine

Install the following packages:

- virtualbox
- vagrant

The Chef DK can be downloaded from the [Chef download page](https://downloads.chef.io/chef-dk/).
To install it enter on the command line

    sudo dpkg -i chefdk_*.deb

enter the following:

    berks update
    kitchen converge


## Workflow Location

The workflow itself can be found in the cookbook under

    cookbooks/mirna/templates/default/consensus.cf.erb
    
and on the test machine under

    /opt/wf/consensus.cf

    
## Workflow execution

Log into the test machine by typing

    kitchen login
    
Now, execute the workflow script by entering

    cuneiform -w /opt/data /opt/wf/consensus.cf
