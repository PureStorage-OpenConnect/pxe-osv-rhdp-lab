---
slug: osv-newvm
id: bwm7dh50rida
type: challenge
title: Create a New Virtual Machine
teaser: Create a New Virtual Machine
notes:
- type: text
  contents: We will now create a Virtual Machine
tabs:
- id: c9uv9xdwqqym
  title: Terminal
  type: terminal
  hostname: cloud-client
  cmd: su - root
- id: ih1xtlzu5gio
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

Step 2 - Test Live Migrations
=====

In order for live migrations to be supported, OpenShift VirtualMachines need to use a PVC with a ReadWriteMany access mode. We can verify this by running:

```bash,run
oc get pvc
```

### Task 1: Live Migrate a VM

Back in the OpenShift Console, click on the `Overview` tab and take note of the node that our VM is running on.

![get ocp node](../assets/livemigrate-vm-01.png)

We can now migrate the VM to a new node by selecting the `Actions` menu, and then clicking `Migrate`

![migrate vm](../assets/livemigrate-vm-02.png)

After a few moments the interface will update with the new node.

It is important to understand that in OpenShift Virtualization, VirtualMachines run inside pods. This migration spawned a new pod, on the destination node, and then live migrated the VM to that pod.

We can view the running pods by executing:
```bash,run
oc get pods
```

Notice that one of our pods is in the `Completed` state, this is because our virtual machine process is no longer in that pod!

We can view the running VMs by typing:
```bash,run
oc get vms
```




Click `Check` to move on to the next challenge