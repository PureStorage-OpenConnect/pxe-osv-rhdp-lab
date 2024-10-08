---
slug: ocp-pxbackup-install
id: xkus03hjisjo
type: challenge
title: Install PX Backup
teaser: Install PX Backup
notes:
- type: text
  contents: We will now install PX Backup on OpenShift
tabs:
- id: yrxa7kotswtp
  title: Terminal
  type: terminal
  hostname: cloud-client
  cmd: su - root
- id: 9cy0tqtkn6l2
  title: OpenShift Console
  type: website
  url: https://console-OpenShift-console.apps.ocp.${_SANDBOX_ID}.instruqt.pxbbq.com
  new_window: true
- id: bm1gobobbfet
  title: pxbbq
  type: website
  url: https://pxbbq-svc-pxbbq.apps.ocp.${_SANDBOX_ID}.instruqt.pxbbq.com
- id: eifhzn2apajx
  title: PX-Backup
  type: service
  hostname: cloud-client
  path: /pxbackup.html
  port: 80
difficulty: basic
timelimit: 600
---





Scenario - Install Portworx Backup on a Red Hat OpenShift Cluster
=====
In this scenario, you'll learn about Portworx Enterprise StorageClass parameters and deploy a demo application that uses RWO (ReadWriteOnce) Persistent Volumes provisioned by Portworx Enterprise, and see how Portworx makes them highly available.

### Reminder: Accessing the Red Hat OpenShift Console

To connect to the console, click on the `OpenShift Console` tab above.

> [!IMPORTANT]
> The `OpenShift Console` tab will open in a new browser window.

We can then log in with the following credentials:

Username: `kubeadmin`
Password: `[[ Instruqt-Var key="KUBEADMIN_PASSWORD" hostname="cloud-client" ]]`



Step 1: Deploy Portworx Backup
=====
In this step, we will deploy Portworx Backup on your cluster using a simple HELM command.

### Task 1: Add the Portworx helm repo
```bash,run
helm repo add portworx http://charts.portworx.io/ && helm repo update
```

### Task 2: Install the Portworx Backup Helm chart
```bash,run
helm install px-central portworx/px-central --namespace central --create-namespace --version 2.7.1 --set persistentStorage.enabled=true,persistentStorage.StorageClassName="px-csi-db",pxbackup.enabled=true,oidc.centralOIDC.updateAdminProfile=false
```

The deployment process takes around 3-5 minutes while all the application components are being deployed in the `central` namespace. If you want to monitor the deployment, use the command below:

```bash,run
until [[ $(kubectl get po --namespace central --no-headers -ljob-name=pxcentral-post-install-hook  -o json | jq -rc '.items[0].status.phase') == "Succeeded" ]]; do
echo "Waiting for post-install hook to succeed..."
sleep 10
done
```

Once the post-install-hook job has reached the completed state, Portworx Backup has been successfully deployed.

### Task 3: Configure the Proxy to connect to PX Backup

PX Backup can be accessed through a LoadBalancer address in your Kubernetes cluster. To make the process of finding this IP address easy, run the following script:

```bash,run
/root/config-proxy.sh
```

You can now select the `PX Backup` tab in instruqt to find a link to your PX Backup instance!

***NOTE:*** You may need to click the refresh button on the tab.

Step 2: Create a Cloud Account for our Backup Targets
=====

In this step we will access Portworx Backup, and configure locations.

### Task 1: Access Portworx Backup
Access Portworx Backup using the Instruqt tab labelled PX-Backup. Click on the link in this tab

### Task 2: Login
Portworx Backup uses `admin/admin` as the default username and password.


### Task 3: Create Cloud Account
Portworx Backup enables users to add different cloud accounts, which allows them to map different backup locations. In this lab, we are going to be working with an S3 Compliant Minio Account.



1. From the dashboard, click on `Settings` icon in the bottom left and select `Cloud Settings`.
2. On the Cloud Settings page, click `+Add` on the right of the `Cloud Accounts` line item.
3. Select `AWS / S3 Compliant Object Store` from the cloud provider drop down and then use `s3-account` as the cloud account name.
4. Enter the access key: `[[ Instruqt-Var key="MINIO_ACCESS_KEY" hostname="cloud-client" ]]`
5. Enter the secret key: `[[ Instruqt-Var key="MINIO_SECRET_KEY" hostname="cloud-client" ]]`
6. Click `Add`.
Now that you have connected your S3 account, we will go ahead and add a backup location in the next step.

Step 3: Create Backup Targets
=====

In this step we will configure backup targets.

If you are not already logged in, please log in to PX Backup by doing the following:


### Task 1: Add an S3 Bucket
Portworx Backup allows users to map object store backup locations (on-prem or in the cloud) to store their application snapshots. Portworx Backup also supports adding an Object-lock bucket to store Write Once Read Many (WORM) immutable snapshots, that allows users to restore their applications to a new Kubernetes cluster if the primary cluster gets hit with a ransomware attack.


In addition to object store backup locations, Portworx Backup also allows users to use NFS shares to store their application snapshots.

To add a backup location, we will need to be on the Cloud Settings page. If you navigated back to the Dashboard, select `Settings` icon bottom left and then select `Cloud Settings`. Here, we will click `+Add` on the right of `Backup Locations`. Enter/Select the following options in the form:

- Select the Object Store radio button.
- Name: `backup-location-1`
- Cloud Account: `s3-account`
- Path / Bucket: `[[ Instruqt-Var key="BUCKETNAME" hostname="cloud-client" ]]`
- Leave the encryption key blank
- Set the region to `us-central-1`
- Set the Endpoint to `[[ Instruqt-Var key="MINIO_ENDPOINT" hostname="cloud-client" ]]`
- Check the `Disable SSL` checkbox


Click Add when you have entered all the details. This will add a backup location that we will use in the next section.

### Task 2: Add an Object-lock S3 Bucket

Repeat the same steps to add the second backup bucket with Object lock enabled. Use the following details to create the second object lock enabled backup location:


- Select the Object Store radio button
- Name: `obj-lock-backup-location-1`
- Cloud Account: `s3-account`
- Path / Bucket: `[[ Instruqt-Var key="BUCKETNAME_OBJECTLOCK" hostname="cloud-client" ]]`
- Leave the encryption key blank
- Set the region to `us-central-1`
- Set the Endpoint to `[[ Instruqt-Var key="MINIO_ENDPOINT" hostname="cloud-client" ]]`
- Check the `Disable SSL`

Notice the pad lock icon by this new backup location. This is because the object lock bucket has a compliance retention period enabled for 7 days.



Step 4: Create Schedule Policies
=====

### Task 1: Create a schedule Policy
Portworx Backup allows users to set their own schedule policies that can be used when creating backup jobs. Portworx Backup allows users to either create ad-hoc, manual, one-time backup to create backup jobs that get triggered at a regular schedule. Using Schedule policies, users can control when they want to trigger backup jobs. These can be periodic, hourly, daily, weekly, and monthly policies.

Use the following steps to create a 15-min backup policy that we will use to create backup jobs:
1. Click on `Settings` icon bottom left and select `Schedule Policies`.
2. Click on the `+` sign on the top right to add a new Schedule policy.
3. Enter the following details to create a new 15 min schedule policy.
- Policy Name: 15-min
- Type: Periodic
- Hours: 0
- Minutes: 15
4. Click `Create` to create the Schedule policy.

### Task 2: Create an Object-lock Schedule Policy

Repeat the same steps to create another Schedule policy with the following details:

- Policy Name: 15-min-object
- Object Lock Policy checkbox: Checked
- Type: Periodic
- Hours: 0
- Minutes: 15
- Click `Create` to create the Schedule policy.

You can create more schedule policies and map it to your organizational SLAs.


Step 5: Create Pre and Post Rules
=====

In this step we will create pre and post backup rules. These rules can trigger scripts to do required actions before and after a backup occurs. Rules will trigger based on the Kubernetes label of the manifest being backed up. Rules are commonly used to quiesce applications before a snapshot is triggered.

Crash-consistent backups are taken at the storage layer without involving the application layer. Applications may have data in cache or in memory that is not written to disk. Relative to the disk image in a given point in time, that in-memory data is lost.

Application-consistent backup is one that informs the application that a backup is about to take place and allows the application to achieve a quiescent and consistent state by flushing any pending I/O operations to disk.

Portworx Backup allows you to take both crash and application consistent backups. Application consistent backups are facilitated by using pre- and post-backup scripts that can be used to flush anything from the memory to the disk before the backup has been taken.

If you haven't already, navigate to the Portworx Backup tab inside the Instruqt UI. Click on the `PX Backup Web Console` link and login using `admin/admin` credentials.

### Task 1: Add a Pre-backup Rule

In this step, we will create a pre-backup rule for a MongoDB.
1. To create a pre-backup rule, navigate to the Portworx Backup UI and click on `Settings` icon bottom left and select `Rules`.
2. Click `+ Add New` on the Backup Rules page.
3. Use the following details to create a backup rule:
- Rule name: mongo-pre
- Pod Selector: `app.kubernetes.io/name=mongo`
- Container: mongo
- Action: Copy paste the following command into the Action textbox.
```bash,run
mongosh -u porxie -p porxie --eval "db.adminCommand( { fsync: 1 } )"
```

Click Add to create the pre-backup rule.

### Task 2: Add a Post-backup Rule


In this step, we will create a post-backup rule for MongoDB that performs a backup of the DB using the `mongodump` utility after the Portworx Backup has run.
1. To create a pre-backup rule, navigate to the Portworx Backup UI and click on `Settings` icon bottom left and select `Rules`.
2. Click `+ Add New` on the Backup Rules page.
3. Use the following details to create a backup rule:
- Rule name: mongo-post
- Pod Selector: `app.kubernetes.io/name=mongo`
- Container: mongo
- Action: Copy paste the following command into the Action textbox.
```bash,run
mongodump -u porxie -p porxie
```

Click Add to create the post-backup rule.


Step 6: Add a Kubernetes Cluster
=====

### Task 1: Add A Kubernetes Cluster to PX Backup

Now we can add our Kubernetes cluster to PX Backup.

1. Navigate to the dashboard by clicking on the `Clusters` icon in the left pane of the Portworx Backup UI and click on the `Add Cluster` button on the top right of your screen.
2. Select the `Others` button.
3. Set the name of the cluster to `instruqt-px`
4. Paste in the kubeconfig file. We can get our current kubeconfig by running:

```bash,run
oc config view --flatten --minify
```

Once the cluster has been added successfully, it will show up on the Portworx Backup Dashboard.

Now that we have done all the pre-work by deploying Portworx Backup and the demo application, we will proceed to the next module, where we will create backup jobs.


Step 7: Add An Order for Some BBQ
=====
To test the backup and restore workflows, we have deployed Portworx BBQ. Let's take a moment to add some orders for BBQ so we know if our later backup and restores are successful.

### Task 1: Access the Portworx BBQ demo application
To access our demo application, navigate to the `Portworx BBQ` tab in the instruqt UI.

> [!IMPORTANT]
> You may need to refresh the `Portworx BBQ` tab if you have an access error.

Select the `Menu` from the top right and click on `Login`.
Enter the following details on the login page:
- Email Address: guest@portworx.com
- Password: guest

Click `Login` button

Next, let's place an order. Navigate to the `Menu` from top right and click on `Order`.

Select the Main Dish, Side Dish 1, Side Dish 2 and Drink that you want for your order and click `Place Order`.

Once the order is placed, click on the order number to view the order.

In this demo application, both the User details and the Order details are stored in a backend MongoDB database that is running on our cluster.

Step 8: Cleanup
=====

One last thing, we have to do a lot of checks. To help us out, please run this cleanup script:

```bash,run
/root/cleanup.sh
```