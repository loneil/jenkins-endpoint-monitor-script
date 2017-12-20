# Jenkins Endpoint Monitor Script
The endpointMonitor.sh script in this repository is one that I wrote to check (with curl) certain routes in different server environments to monitor their uptime. It's intended for use in a Jenkins job with Jenkins running in a Linux environment.

If any of the requests do not return a 200 then the Jenkins job that runs this script fails. 
This script uses simple GET statements from curl, but you can monitor the curl statment to do whatever.

## Jenkins integration
This script could be used in any context (no Jenkins required), but for my usage I've saved it as a Managed Script in Jenkins.

The
```
exit 1
```
statement in the script is what causes Jenkins to fail a job if a non-200 is detected.

Using the Managed Scripts pugin (available at https://plugins.jenkins.io/managed-scripts) allowed me to set it up so any job could reuse it.

In Managed Scripts I added the script, with an argument.
Jenkins > Managed files > Managed script file

Then in any Jenkins job I wish to run this monitor, I add the managed script as a build step.

I set up multiple jobs to run at intervals to detect outages at the endpoints. 

