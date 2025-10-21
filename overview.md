# **Subject:** RE: Deployment & User Access Cleanup Tasks

Howdy team,

As you now, we recently had a new intern, Tim, join us at the systems team. Unfortunately, his work has had caused some issues within our production server and we'd like to get it resolved as soon as possible. He's told us everything that he remembers doing before our systems went down, and it's your job to figure out what needs to be done to get our scripts back up and running.

---
### **1. Improperly Stopped Script**
* Tim told us that he accidentally pressed Ctrl+Z on one of long running processes, called **DOSTOPTHISPROCESS**, on one of our service accounts, **svc**, and it is currently stopped. You will need to get this process back up and running ASAP
  1. Figure out which the PID this process was running as
  2. Resume the process so that our users can continue using it (You will need root permissions to do this)

### **2. Manual Service Deployment**
* While you're still fiddling with this server, one of our newest services, **CameraService.sh** is ready to be deployed. Unfortunately, the dev team hasn't given us a timeline on when they can set up the DevOps pipeline for this new service, so you will have to get it up and running manually on the **svc** service account.
  1. Switch to the **svc** account
  2. Look for the CameraService.sh script in **/opt/files**
  3. Run it in the background
  4. Disown the process from your current terminal session to let it be permanent

Thanks and Gig 'em,  
**Kevin G.**  
Systems Administration Lead
