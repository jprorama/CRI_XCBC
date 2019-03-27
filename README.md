Simple playbooks to install OpenHPC version 1.0 using Ansible. 

See the doc/README.md for a tutorial on using these scripts in a VirtualBox environment.

The Ansible layout is fairly simple, using a series of roles for different parts of the installation process. 

This repo will get you to the point of a working slurm installation across your cluster. It does not 
currently provide any scientific software or user management options! 

The basic usage is to set up the master node with the initial 3 roles (pre\_ohpc,ohpc\_install,ohpc\_config)
and use the rest to build node images, and deploy the actual nodes (these use Warewulf as a provisioner by default). 

Trigger the roles individually via tags, like:

```
ansible-playbook -t pre_ohpc -i inventory/headnode headnode.yml
```

None of these Ansible roles actually touch the compute nodes directly - at most, they build a new vnfs image and
trigger a reboot. 

A more detailed description is available in the /doc folder.

### Issues and Work arounds

1. If you encounter an issue with OHPC node provisioning due to GPG key errors as mentioned in https://github.com/jprorama/CRI_XCBC/issues/77. Please run the below command as a work around from outside your VM:

    `vagrant box update`

2. After you run the above command if you were to get a `"kernel mismatch error"`. To get past this error please run the below commands:

    `vagrant ssh ohpc`

    `uname -r`

    Copy and paste this kernel version in the group_vars/all to update the kernel version in the `build_kernel_ver` variable.

3. If you encounter an issue with nodes_vivify role in updating the slurm status on nodes, specifically the error `slurm_update error: Invalid node state specified`. Please increase the compute node memory to 6GB in your Virtual Box.
