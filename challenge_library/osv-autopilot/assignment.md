---
slug: ocp-install
type: challenge
title: Autopilot with Openshift Virtualization
teaser: Autopilot with Openshift Virtualization
notes:
- type: text
  contents: We will now configure Autopilot
tabs:
- title: Terminal
  type: terminal
  hostname: cloud-client
  cmd: su - root
- id: m2l5jn9ldfpa
  title: Openshift Console
  type: website
  url: https://console-openshift-console.apps.ocp.${_SANDBOX_ID}.instruqt.pxbbq.com
  new_window: true
difficulty: basic
timelimit: 600
---





Scenario - Automatic storage management with Autopilot
=====
In this scerario, we will configure autopilot to grow a PVC in the event of our virtual disk runs low on space.

We have created a new virtual machine that we will be using for this excercise.

### Reminder: Accessing the Openshift Console

To connect to the console, click on the tab above.

> [!IMPORTANT]
> The `Openshift Console` tab will open in a new browser window. Because we are using a self signed certificate, you will need to bypass your web browsers security features to connect.

We can then log in with the following credentials:

Username: `kubeadmin`
Password: `[[ Instruqt-Var key="KUBEADMIN_PASSWORD" hostname="cloud-client" ]]`


Configure our Autopilot Rule
=====

Au

### Task 1: Review the Autopilot Rule

Let's review the Autopilot rule by running the following
```bash,run
ccat autopilotrule.yaml
```
The rule displayed will:
 - ***Line 9:*** Target PVCs with the Kubernetes label `app: autopilot`

 - ***Lines 14-17:*** Monitor if capacity usage grows to or above 30%

 - ***Line 24:*** Automatically grow the volume and underlying filesystem by 50% of the current volume size if usage above 30% is detected

 - ***Line 26:*** Not grow the volume to more than 20Gi

Apply the yaml to create the Portworx Autopilot rule:
```bash,run
oc apply -f autopilotrule.yaml
```

### Task 2: Label our Virtual Machine PVC

Autopilot will expand PVCs that have the `app: autopilot` label applied. We will apply that label to our virtual machine's PVC'

```bash,run
oc label pvc centos-stream9-autopilot-data-disk  app=autopilot --overwrite
```

```bash,run
oc get pvc centos-stream9-autopilot-data-disk 
```

> Take note of the size of our pvc!

Step 3 - Add some storage space
=====
We will use the DD command to add some storage space to our virtual machine.

We could of course log in to our VM though the console, but that would require that we log in to the virtual machine with the supplied password.

One of the advantages of an extensible framework like Openshift is that much of the information about our environment is stored as metadata. 

### Task 1: Start filling the disk

Let's execute a command inside of our virtual machinen using `oc exec`


```bash,run
virtctl ssh cloud-user@centos-stream9-autopilot -t "-o StrictHostKeyChecking=no" -c 'sudo touch /data/file; sudo shred -n 1 -s 900M /data/file'&
```


### Task 5: Observe the Portworx Autopilot events
Run the following command to observe the state changes for Portworx Autopilot:
```bash,run
watch oc get events --field-selector \
 involvedObject.kind=AutopilotRule,involvedObject.name=volume-resize \
 --all-namespaces --sort-by .lastTimestamp -o custom-columns=MESSAGE:.message
```

You will see Portworx Autopilot move through the following states as it monitors volumes and takes actions defined in Portworx Autopilot rules:
 - ***Initializing*** (Detected a volume to monitor via applied rule conditions)

 - ***Normal*** (Volume is within defined conditions and no action is necessary)

 - ***Triggered*** (Volume is no longer within defined conditions and action is necessary)

 - ***ActiveActionsPending*** (Corrective action is necessary but not executed yet)

 - ***ActiveActionsInProgress*** (Corrective action is under execution)

 - ***ActiveActionsTaken*** (Corrective action is complete)

Once you see ActiveActionsTaken in the event output, press `CTRL+C` to exit the watch command.

### Task 6: Verify the Volume Expansion
Now let's take a look at our PVC - note the automatic expansion of the volume occurred with no human interaction and no application interruption:
```bash
oc get pvc
```
> [!IMPORTANT]
> You should now see the data volume size has now increased by 100%.



We can now observe the freespace in our virtual machine by running:
```bash,run
virtctl ssh cloud-user@centos-stream9-autopilot -t "-o StrictHostKeyChecking=no" -c 'df -h'
```
Notice the size of the data disk at mounted at `/mnt`

You've just configured Portworx Autopilot and observed how it can perform automated capacity management based on rules you configure, and be able to "right size" your underlying persistent storage as it is needed!


DEBUG
=====

This is a debug setting that has some information on refreshing the lab.

We can delete and provision a new VM with:
```bash,run
oc delete -f osv-autopilot-vm.yaml
oc apply -f osv-autopilot-vm.yaml
sleep 30
# Wait for the VM to boot

until virtctl ssh cloud-user@centos-stream9-autopilot -t "-o StrictHostKeyChecking=no" -c 'lsblk'; do
    echo "waiting for VM to boot"
    sleep 10
done
```

The above *should* delete and restart the vm.

Some helpful places to look at at logs:
```bash,run
virtctl ssh cloud-user@centos-stream9-autopilot -t "-o StrictHostKeyChecking=no"
```

`sudo journalctl` shows the disk growing, and we can see the PVC resize.

### Useful links:
https://docs.portworx.com/portworx-enterprise/operations/operate-kubernetes/storage-operations/manage-kubevirt-vms.html

https://docs.openshift.com/dedicated/virt/virtual_machines/virtual_disks/virt-expanding-vm-disks.html

https://kubevirt.io/user-guide/storage/disks_and_volumes/#disk-expansion

