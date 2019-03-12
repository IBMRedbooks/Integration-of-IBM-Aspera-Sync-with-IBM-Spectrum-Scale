# Use Aspera sync with file lists generated by LIST Policy

These tools run simple list LIST policies (without external script) using the mmapplypolicy command and feed the results 
into ascp or async. 


## Disclaimer

These examples are provided on a an as-is basis. Use it on your own risk. IBM cannot be made liable for any damage 
caused by the use of these examples. Do not distribute any of these examples.  


## Getting started
First of all adjust connection boundaries in transfer.rc. Here is an example:

    SOURCE_DIR="<source path>"
    REMOTE_DIR="<destination path>"
    FSETNAME="myfileset"
    SSH_HOST=<target-IP>
    SSH_USER=<ssh user name>
    SSH_KEY_PATH=<path to private ssh key of user>
    TRANSFER_RATE=1G


## Using ascp to copy the files

File ascp_policy provides the policy for the file identification. The example only looks at a fileset (FSETNAME) and transfers all files that have been modified after LAST_XFER which is a timestamp. FSETNAME and LAST_XFER are passed to the policy from the mmapplypolicy command executed in ascp_policy_transfer.sh.

File ascp_policy_transfer.sh is a script that runs the policy (ascp_policy) using mmapplypolicy and feeds the resulting filelist into ascp. The program can be invoked with a time stamp of format "YYYY-MM-DD hh:mm:ss" (quotes are required). This timestamp is used as LAST_XFER time and results in all files to be selected that have been modified after this time stamp. 

File run-ascp.sh is invoked from ascp_policy_transfer.sh and runs ascp using the file list.

To run the program:
  - adjust transfer.tc
  - adjust the policy file when required
  - adjust the mmapplypolicy command in the ascp_policy_transfer.sh file (e.g. node name)
  - run the program: 
  
        ./ascp_policy_transfer "2018-06-06 12:00:00"


Note, if files are migrated on the source and identified from the policy engine, they are recalled for the transfer.
If files on the target are migrated and the corresponding file on the source is identified by the policy engine it will be recalled on the target. 


## Using  async to copy files

The integration of async with LIST policies works similar to ascp. 
File ascp_policy provides the policy for the file identification. The example only looks at a fileset (FSETNAME) and transfers all files that have been modified after LAST_XFER which is a timestamp. FSETNAME and LAST_XFER are passed to the policy from the mmapplypolicy command executed in ascp_policy_transfer.sh.

File async_policy_transfer.sh is a script that runs the policy (async_policy) using mmapplypolicy and feeds the resulting filelist into async. The program can be invoked with a time stamp of format "YYYY-MM-DD hh:mm:ss" (quotes are required). This timestamp is used as LAST_XFER time and results in all files to be selected that have been modified after this time stamp. For example: ./ascp_policy_transfer "2018-06-06 12:00:00"

File run-async is invoked from async_policy_transfer.sh and runs async using the file list.


Note, if files are migrated on the source and identified from the policy engine, they are recalled for the transfer.
If files on the target are migrated and the corresponding file on the source is identified by the policy engine it will be recalled on the target. 

To run the program:
  - adjust transfer.tc
  - adjust the policy file when required
  - adjust the mmapplypolicy command in the async_policy_transfer.sh file (e.g. node name)
  - run the program: 
  
        ./async_policy_transfer "2018-06-06 12:00:00"


Note, if files are migrated on the source and identified by the LIST policy they are not recalled if they have not changed on the source AND the existing file on the target has been transferred using async with the same session ID. If files on the target are migrated and the corresponding file on the source is identified by the policy engine it will also not be recalled under the same conditions on the target. 