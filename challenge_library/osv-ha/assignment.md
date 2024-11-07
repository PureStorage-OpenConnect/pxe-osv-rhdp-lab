---
slug: ocp-install
type: challenge
title: Perform an HA Failover
teaser: Perform an HA Failover
notes:
- type: text
  contents: We will now create a Virtual Machine
tabs:
- title: Terminal
  type: terminal
  hostname: cloud-client
  cmd: su - root
- id: m2l5jn9ldfpa
  title: OpenShift Console
  type: website
  url: https://console-openshift-console.apps.ocp.${_SANDBOX_ID}.instruqt.pxbbq.com
  new_window: true
difficulty: basic
timelimit: 600
---





Scenario - Persistent Storage Volume Provisioning and Availability for Virtual Machines
=====
In this scenario, we will learn about how to provision a virtual machine on OpenShift Virtualization with Purestorage.

### Reminder: Accessing the Red Hat OpenShift Console

To connect to the console, click on the `OpenShift Console` tab above.

> [!IMPORTANT]
> The `OpenShift Console` tab will open in a new browser window.

We can then log in with the following credentials:

Username: `kubeadmin`
Password: `[[ Instruqt-Var key="KUBEADMIN_PASSWORD" hostname="cloud-client" ]]`




Step 1 - Deploy a Virtual Machine
=====
Start by logging in to the OpenShift console with the information above.



### Task 1: Create a new VM

Navigate to the virtualzation > overview menu

![Select VMs](../assets/create-vm-01.png)

Click the `Create Virtual Machine` button

![Click Button](../assets/create-vm-02.png)

Select the Centos Stream image. We can also use the default instance type.

![Select CentOS](../assets/create-vm-03-2.png)

Verify that our StorageClass is set to `px-csi-db` and click `Create VirtualMachine`

![Select StorageClass](../assets/create-vm-04.png)

This will automatically start the virtual machine after a short provisioning process.

> [!IMPORTANT]
> It can take a couple of minutes for our VM to boot the first time

Explore the tabs for this virtual machine. We can view metrics, configure snapshots, and even view the YAML configuration to make automating easy.

![Interact with VM](../assets/create-vm-06.png)

> [!IMPORTANT]
> The Virtual Machine name will be different in your environment


Step 2 - Providing HA
=====

### Task 1: Proving HA

We will now induce a failure in our OpenShift cluster.

It is important to understand that in OpenShift Virtualization, VirtualMachines run inside pods. As we learned above, our virtual machine is actually running from inside a pod. Let's find out which node our virtual machine is running on:

```bash,run
NODENAME=$(oc get pods -o wide | grep 'Running' | awk '{print $7}' | head -n 1)
echo "Your VM is running on node: ${NODENAME}"
```

let's cause a reboot of this node:
We will now debug the node:
```bash,run
oc debug node/$NODENAME
```

> [!IMPORTANT]
> Running `oc debug node/$NODENAME` can take a few seconds as a pod needs to be attached to the node.

Chroot to the host
```bash,run
chroot /host
```

And finally, reboot the OpenShift worker node hosting the running MongoDB pod:
```bash,run
sudo reboot
```

Let's watch our VM and pod status in the default namespace:
```bash,run
watch oc get pods,vms -o wide
```

Take note of the NODE column. We will see a new launcher pod start on a new node.

We can verify that our virtual machine is again running in the OpenShift Console, but because this was an unplanned outage, the VM has rebooted.

Click `Check` to move on to the next challenge
