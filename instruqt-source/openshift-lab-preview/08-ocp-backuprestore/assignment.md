---
slug: ocp-backuprestore
id: qc3gbvqgujbe
type: challenge
title: Kubernetes Backup and Restore
notes:
- type: text
  contents: Please wait while we get some things ready!
tabs:
- id: ejrgh8y7l3w7
  title: Terminal
  type: terminal
  hostname: cloud-client
- id: y0aijepwuwjo
  title: pxbbq
  type: website
  url: https://pxbbq-svc-pxbbq.apps.ocp.${_SANDBOX_ID}.instruqt.pxbbq.com
- id: s0gmc7cyezy4
  title: PX-Backup
  type: service
  hostname: cloud-client
  path: /pxbackup.html
  port: 80
difficulty: basic
timelimit: 1800
---

Scenario - RedHat OpenShift Backup and Restore using Portworx Backup
=====
Portworx Backup allows users to protect their applications from accidental deletions, data corruption and data loss, etc. by creating end-to-end application snapshots, and allowing users to restore these applications when needed.


Step 1 - Backup PX BBQ using Portworx Backup
=====
In this scenario we will use Portworx Backup to take an end-to-end application backup of our PX-BBQ application that we deployed in the last step. Portworx Backup allows users create custom backup jobs based on the following resources:
- Namespaces
- Namespace labels
- Resource Types
- Resource Labels

In this module, we are just going to backup the entire namespace for our demo application.

Navigate to the PX-Backup tab inside the Instruqt UI. Click on the `PX Backup Web Console` link

Use the credentials `admin/admin` to login.

Click on the `Clusters` icon on the left navigation pane, then click on the `instruqt-px` cluster. This will present a summary of your protected objects. Click on the `Applications` tab. Here you will see a list of all the different namespaces configured on your cluster.

1. Select the `pxbbq` namespace from the list and click `Backup` button. This will automatically select all the different Kubernetes resources running in the pxbbq namespace.
2. In the `Create Backup` widget, enter the following details:
- Enter name for Backup: pxbbq-ns-backup
- Backup location: `obj-lock-backup-location-1`
- Select the `On a schedule` radio button and select the `15-min-object` schedule policy.
- Select the `mongo-pre` and `mongo-post` rules
- Click `Create` to do create a scheduled backup job for our Portworx BBQ application.

>[!IMPORTANT]
> You can monitor the backup job using the Backups tab. Use the refresh button inside the Portworx Backup UI, on the top right of the Backup Timeline to refresh the page. Once the backup job is completed successfully, it turns green. Please do not move on to the next step until the backup completes.

Step 2 - Accidental application deletion
=====

In this step, we will navigate back to the `terminal` tab in instruqt and use the following commands to delete the application from our cluster.
But, before we delete all the resources, let's use the following command to look at all the resources that we will delete, so we can confirm their restore.

```bash
oc get pods,svc,pvc,deploy,rs -n pxbbq
```
You should see all the Kubernetes objects that are running in the `pxbbq` namespace.

Next, use the following commands to delete all these resources.

```bash
oc delete -f pxbbq-web.yaml
sleep 5
oc delete -f pxbbq-mongo.yaml
sleep 5
oc delete pvc -n pxbbq mongo-data-dir-mongo-0
```

Verify that everything was deleted using the following command:
```bash
oc get all -n pxbbq
```


Step 3 - Restore the application
=====


### Task 1: Restore the Application
In this step, we will use Portworx Backup to restore our application from its backup snapshot.
To restore the application:
1. Click on the `Clusters` icon on the left navigation pane.
2. Click on the `instruqt-px` cluster.
3. Click on the Backup tab, and find the snapshot of the application that you want to restore from.
4. Click on the three dots on the end of the snapshot line, and click Restore.
5. Give the restore job a name, and then select the `instruqt-px` cluster from the drop down menu.
6. Click the `Replace Existing Resources` checkbox.
7. Once everything looks good, click `Restore` to initiate a restore operation.
8. You will be redirected to the Restore tab, where you can monitor the status of the restore job. Once the restore has been completed successfully, you will see a green sign in front of it.
9. To validate the restore operation, let's go back to the `terminal` tab in Instruqt and use the following command:

You can run the following to check on the status of your restore
```bash
watch oc get pods,svc,pvc,deploy,rs -n pxbbq
```

Wait for our running pods to have the `1/1 READY` status, then press `ctrl-c` to terminate our watch command.

### Task 2: Verify the Restore

Let's validate that our order is still in Portworx BBQ:
1. Click on the `Portworx BBQ` tab
2. Click on the menu in the upper-right corner.
3. Select `Order History`

This is how easy it is to create end-to-end application backups using Portworx Backup.
