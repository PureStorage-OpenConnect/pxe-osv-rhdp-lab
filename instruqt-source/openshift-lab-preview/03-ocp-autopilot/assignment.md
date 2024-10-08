---
slug: ocp-autopilot
id: o6u7i6aetlhb
type: challenge
title: Portworx Autopilot on OpenShift
teaser: Portworx Autopilot on OpenShift
notes:
- type: text
  contents: Let's automatically manage volume space with autopilot
tabs:
- id: yvnoxkfjvjmu
  title: Terminal
  type: terminal
  hostname: cloud-client
  cmd: su - root
- id: yzawo3l64gka
  title: OpenShift Console
  type: website
  url: https://console-openshift-console.apps.ocp.${_SANDBOX_ID}.instruqt.pxbbq.com
  new_window: true
difficulty: basic
timelimit: 600
---



Scenario - Automated Volume Expansion using Portworx Autopilot
=====
Portworx Autopilot is a rule-based engine that responds to changes from a monitoring source. Autopilot allows you to specify monitoring conditions along with actions it should take when those conditions occur.

### Reminder: Accessing the Red Hat OpenShift Console

To connect to the console, click on the `OpenShift Console` tab above.

> [!IMPORTANT]
> The `OpenShift Console` tab will open in a new browser window.

We can then log in with the following credentials:

Username: `kubeadmin`
Password: `[[ Instruqt-Var key="KUBEADMIN_PASSWORD" hostname="cloud-client" ]]`



### Task 1: Create Autopilot Rule
Autopilot rules allow users to create IFTTT (IF This Then That) rules, where Autopilot will monitor for a condition and then perform an action on your behalf.

Let's create a simple rule that will monitor persistent volumes associated with objects that have the `app: disk-filler` label and in namespaces that have the label `type: db`. First, let's take a look at the YAML for the rule and call out the important lines:

```bash,run
ccat autopilotrule.yaml
```

The rule displayed will:
 - ***Line 9:*** Target PVCs with the Kubernetes label `app: disk-filler`

 - ***Line 13:*** Target PVCs in namespaces with the label `type: db`

 - ***Lines 18-21:*** Monitor if capacity usage grows to or above 30%

 - ***Line 28:*** Automatically grow the volume and underlying filesystem by 100% of the current volume size if usage above 30% is detected

 - ***Line 30:*** Not grow the volume to more than 20Gi

Apply the yaml to create the Portworx Autopilot rule:
```bash,run
oc create -f autopilotrule.yaml
```

### Task 2: Identify Namespaces Selected
Since our Portworx Autopilot rule only targets namespaces that have the label `type: db`, let's make sure our namespace has the proper label:
```bash,run
oc get ns -l type=db
```
There is our `autopilot` namespace in the filtered results - we are good to go!

### Task 3: Deploy PVCs for Disk Filler
Review the yaml for the volume, and note the label `app: disk-filler` on ***Line 6***:
```bash,run
ccat disk-filler-pvc.yaml
```
Then let's apply it to deploy our PVC:
```bash,run
oc create -f disk-filler-pvc.yaml -n autopilot
```
Ensure that the PVC is created and bound:
```bash,run
oc get pvc -n autopilot
```
> [!IMPORTANT]
> Note that the original size of the PVC for our data volume is 10Gi.

### Task 4: Deploy the Disk Filler Pod
Review the yaml for our busybox pod that will fill our volume with data. On ***Line 27*** you can see we'll use a simple `dd` command to fill the disk by generating random data:
```bash,run
ccat disk-filler.yaml
```
And then deploy the pod:
```bash,run
oc create -f disk-filler.yaml -n autopilot
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
```bash,run
oc get pvc -n autopilot
```
> [!IMPORTANT]
> You should now see the data volume has been doubled from the original capacity of 10Gi when the PVC was initially created.

You've just configured Portworx Autopilot and observed how it can perform automated capacity management based on rules you configure, and be able to "right size" your underlying persistent storage as it is needed!

Cleanup
===
Run the following script to clean up demo resources:
```bash,run
./cleanup.sh
```
