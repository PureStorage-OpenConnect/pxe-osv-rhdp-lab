---
slug: ocp-install
type: challenge
title: Create a New Virtual Machine
teaser: Create a New Virtual Machine
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




Click `Check` to move on to the next challenge