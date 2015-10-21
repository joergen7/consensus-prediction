# Workflow for the Consensus Prediction of Proteomics Mass Spectrometric Data
Mass spectrometry (MS) is currently the tool of choice to detect proteins in complex mixtures. 
Interpreting MS/MS spectra manually is possible, but thousands can be measured per hour and therefore computational tools
are used to establish peptide spectrum matches (PSM). A battery of tools have been published 
(OMSSA, X!Tandem, pFind, MSAmanda, MSGF+, MassWizz, ...) and are being sold (Sequest, Mascot, PEAKS, ...).
It has been shown that using multiple tools allows the establishment of more confident PSMs.
Therefore, consensus prediction is popular if an adequate compute infrastructure is available.
Oliver Kohlbacher's group published a consensus scoring algorithm [(Nahnsen et al. 2011 )](http://pubs.acs.org/doi/abs/10.1021/pr2002879).
They used OMSSA, X!Tandem, and Mascot in there study. We were not able to find the workflow they build in OpenMS and,
therefore, prepared the workflow using mostly OpenMS. Since not everyone has access to the commercial tool Mascot,
we elected to use MSGF+ (has been shown to perform as well as Mascot) to replace it.

The workflow presented here has a number of additional advantages:

    1) Seamless installation of all components
    2) Distributed computation
    3) No dependency on commercial tools

Different from the workflow presented in the [(Nahnsen et al. 2011 )](http://pubs.acs.org/doi/abs/10.1021/pr2002879), we chose to use a target and a decoy database and perform the consensus on both of them individually before calculating an FDR. We reason that we loose less PSMs in this manner when compared to performing an FDR before calculating the consensus.

## Executing the Workflow
When executing the workflow, the files mods.xml and usermods.xml (two required files for OMSSA) must exist in the current directory. A protein database needs to be in the current directory and its name must be protein.fasta. The files should only contain relevant protein information and must not contain any decoy sequences. All spectra files (mgf, mzXML, mzML, ms2 formats are supported) that are intended to be run need to be tared (tar cf spectra.tar ..SPECTRA..FILES..) and the spectra.tar file needs to be in the current directory. Precursor mass tolerance is set to 0.8 by default and fragment mass tolerance to 0.3. To change these settings, the consensus.cf file needs to be edited manually (any text editor will do .. changes values in lines 8 and 9 to suit your instrument error).
If the following files:

    1) mods.xml
    2) usermods.xml
    3) protein.fasta
    4) spectra.tar
    5) consensus.cf
    
are in the current directory and if all below prerequisities are fullfilled then the workflow can be started by:

    cuneiform consensus.cf
    

## Prerequisites

Install the following packages:

- virtualbox
- vagrant

The Chef DK can be downloaded from the [Chef download page](https://downloads.chef.io/chef-dk/).
To install it enter on the command line

    sudo dpkg -i chefdk_*.deb


## Initialize host machine

To build the VM specified in this cookbook for the first time, change your git
base directory and enter the following:

    git clone https://github.com/joergen7/consensus-prediction.git
    cd consensus-prediction
    berks install
    kitchen converge
    
You can log into the newly built VM by entering

    kitchen login
    
You can drop the VM by entering

    kitchen destroy


## Workflow Location

The Cuneiform workflow can be found in the cookbook under

    consensus-prediction/templates/default/consensus.cf.erb
    
and on the test machine under

    /opt/wf/consensus.cf

    
## Workflow execution

Log into the test machine by typing

    kitchen login
    
Now, execute the workflow script by entering

    cuneiform -w /opt/data /opt/wf/consensus.cf
    
    
## Synchronizing with the remote repository

To synchronize your local repository with the remote version at Github change to
the cookbook directory and enter

    git pull
    berks update
    kitchen converge
    alternatively: sudo chef-client -z -r "consensus-prediction::_common,consensus-prediction::default"
    
If you have doubts whether the VM is still in a usable state you can destroy it
before converging.
    
    
## Share your changes

To make your changes public, you need to merge your changes to with the remote
repository. Do so by changing to the cookbook directory and entering:

    git add --all
    git commit
    git push
