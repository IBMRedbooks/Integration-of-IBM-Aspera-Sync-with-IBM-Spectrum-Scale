# aspera-gpfs-policy
A set of scripts to use the GPFS policy engine to select files and transfer them using Aspera tools


### Folder [gpfs_policy_list](gpfs_policy_list/) - Integration with LIST policies
In this folder are some policies and script to integrate ascp and async with list policies. A master script runs the policy, creates the output files and provides these to ascp or async for processing

--------------------------------------------

### Folder [gpfs_policy_external](gpfs_policy_external/) - Integration with EXTERNAL LIST policies
In this folder are some policies and tools to integrate ascp and async as external scripts with external LIST policies. All that is required is to run the mmapplypolicy command. 
