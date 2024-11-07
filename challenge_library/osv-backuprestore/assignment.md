---
slug: ocp-install
type: challenge
title: Backup and Restore a Virtual Machine
teaser: Backup and Restore a Virtual Machine
notes:
- type: text
  contents: We will now backup and restore a virtual machine using PX Backup
tabs:
- title: Terminal
  type: terminal
  hostname: cloud-client
  cmd: su - root
- title: pxbbq
  type: website
  url: https://pxbbq-svc-pxbbq.apps.ocp.${_SANDBOX_ID}.instruqt.pxbbq.com
  new_window: false
- title: PX-Backup
  type: service
  hostname: cloud-client
  path: /pxbackup.html
  port: 80
- id: m2l5jn9ldfpa
  title: Openshift Console
  type: website
  url: https://console-openshift-console.apps.ocp.${_SANDBOX_ID}.instruqt.pxbbq.com
  new_window: true
difficulty: basic
timelimit: 600
---





Scenario - Persistent Storage Volume Provisioning and Availability
=====
In this scenario, we will use PX Backup to backup and restore an openshift virtual machine

### Reminder: Accessing the Openshift Console

To connect to the console, click on the tab above.

> [!IMPORTANT]
> The `Openshift Console` tab will open in a new browser window. Because we are using a self signed certificate, you will need to bypass your web browsers security features to connect.

We can then log in with the following credentials:

Username: `kubeadmin`
Password: `[[ Instruqt-Var key="KUBEADMIN_PASSWORD" hostname="cloud-client" ]]`




Step 1 - 
=====
