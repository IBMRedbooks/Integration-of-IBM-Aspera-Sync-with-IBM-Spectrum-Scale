# Aspera sync as external script invoked by the policy engine

These tools provide an example how to use Aspera sync as external script with EXTERNAL LIST policies. IN this case Aspera sync (ascp and async) are invoked by the policy itself. 


## Disclaimer

These examples are provided on a an as-is basis. Use it on your own risk. IBM cannot be made liable for any damage caused by the use of these examples. Do not distribute any of these examples.  


## Getting started:

First of all adjust connection boundaries in transfer.rc

    SOURCE_DIR="<source path>"
    REMOTE_DIR="<destination path>"
    FSETNAME="myfileset"
    SSH_HOST=<target-IP>
    SSH_USER=<ssh user name>
    SSH_KEY_PATH=<path to private ssh key of user>
    TRANSFER_RATE=1G


## Using ascp to copy files

File ascp_policy provides the EXTERNAL LIST policy for the file identification. The external script should be run-ascp.sh located in the program path. The path of the program run-ascp.sh must be adjusted in the EXTERNAL LIST RULE:

    RULE EXTERNAL LIST 'transfer-list' EXEC '/<your-path>/run-ascp.sh'. 

The example only looks at a fileset (FSETNAME) and transfers all files that have been modified after LAST_XFER which is a timestamp. FSETNAME and LAST_XFER are passed to the policy from the mmapplypolicy command that is run manually.

File ascp_policy_invokation.txt contains an example of the mmapplypolicy command:

    # mmapplypolicy fsname -P ascp_policy -N nodename --single-instance -m 1 -M LAST_XFER=`date -d "2018-05-30 13:30:00" +%s` -M FSETNAME=testaspera

The time stamp for file identification is given with the -M LAST_XFER parameter. The fileset is given with the -M FSETNAME parameter

To run the program do the following:
  - adjust the policy in ascp_policy
  - run the mmapplypolicy command with this policy (adust -N nodename, -s tempdir)
  
Note, if files are migrated on the source and identified from the policy engine, they are recalled for the transfer.
If files on the target are migrated and the corresponding file on the source is identified by the policy engine it will be recalled on the target. 


## Using async to copy files

File async_policy provides the EXTERNAL LIST policy for the file identification. The external script should be run-async.sh located in the program path. The path of the program run-async.sh must be adjusted in the EXTERNAL LIST RULE:

    RULE EXTERNAL LIST 'transfer-list' EXEC '/<your-path>/run-async.sh'. 

The example only looks at a fileset (FSETNAME) and transfers all files that have been modified after LAST_XFER which is a timestamp. FSETNAME and LAST_XFER are passed to the policy from the mmapplypolicy command that is run manually.

File async_policy_invokation.txt contains an example of the mmapplypolicy command:

    # mmapplypolicy fsname -P async_policy -N nodename --single-instance -m 1 -M LAST_XFER=`date -d "2018-05-30 13:30:00" +%s` -M FSETNAME=testaspera

The time stamp for file identification is given with the -M LAST_XFER parameter. The fileset is given with the -M FSETNAME parameter

To run the program do the following:
  - adjust the policy in async_policy
  - run the mmapplypolicy command with this policy (adust -N nodename, -s tempdir)

Note, if files are migrated on the source and identified by the LIST policy they are not recalled if they have not changed on the source AND the existing file on the target has been transferred using async with the same session ID. If files on the target are migrated and the corresponding file on the source is identified by the policy engine it will also not be recalled under the same conditions on the target. 
