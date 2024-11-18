#!/usr/bin/env bash



#################################################################
# Version
# 0.2.11

# First number: Major changes (re-writes, etc)
    # When this number increments, all other numbers should be reset to 0
# Second number: Changes that have been run through dpxd-challenge tests (dpxd-test tracks)
    # When this number increments, the last number should be reset to 0
# Third number: TSCC tested changes that have been pushed to dpxd-main
# Fourth number (optional): patch release

# Because the releases are gated, we know a few things about versioning:

# x.x.0 releases have passed dpxd-challenge tests
  # These releases will be marked as latest stable

# x.0.0 is the first release of a new major version which is usually a re-write
  # These releases will be marked as pre-release

# x.x.x releases have passed TSCC tests
  # These releases will be marked as pre-release

# Append an -alpha for untested changes, append -beta for changes that have had initial testing

# This dpxd-main can be updated with: 'test_scc --track=dpxd-main --pattern=TMEISTHEBESTEVAR'

#################################################################
# Change log

### 0.1.2 - 07/15/2024
# - Changed GKE version
# - TSCC tested and pushed to dpxd-main


### 0.1.3 - 7/23/2024 CC
# - Added gcp_utilserver_create function
# - added gcp_utilserver_rancher function to install rancher
# - added gcp_utilserver_rancher_cluster function to create a rancher cluster on GCP hosts. This updates the K8SVERSION variable
# - changed portworx_install function to detect rancher version and modify spec file
# - Changed nginx config write function to detect rancher and use a different method to populate IP addresses (sshconfig) as well as add rancher server to port 85
# - Added wait_ready function
# - Added get_ip_from_sshconfig function to pull the ip address from SSH config

### 0.1.4 - 7/24/2024 CC
# - [x] Add release channel to GKE install
# - [x] Update K8S version var to be dynamic to feed portworx install
# - added debugging to rancher functions

### 0.2.0 - 8/9/2024 CC
# - Passed DPXD tests

### 0.2.1 - 8/15/24 CC
# - [x] fix AGENTCMD null error
# - [x] create create_gke_cluster_dr function
# - [x] build cloud drive function
# - [x] Add wait-raidy timeout
# - [x] route53 secret
# - [x] add agent vars to write_bashrc
# - [x] get mvp of ocp
# - [x] ocp px operator fixed
# - [x] added bypass_requirements flag to portworx_install
# - [x] using portworx_install for all installs
# - [x] remove portworx_ocp_install
# - [x] fix nginx for openshift. NGINX should disable on openshift now
# - [x] get ssh configured for openshift. SSH is configured but a little useless as it uses a private network
# - [x] Removed wait-ready-ocp_portworx and tested with the generic function
# - [x] run tscc tests

### 0.2.2 - 08/29/2024 CC
# - [x] fix async license issue
# - [x] fix async auth issue
# - [x] update aws auth secrets
# - [X] change OCP token to a secret key
# - [x] Add kubecon meta function
# - [x] add license to async function, needs to be in a secret
# - [x] add route53 cleanup
# - [x] add px license cleanup
# - [x] fix pxbbq chatbot
# - [x] use try function for mc alias add
# - [x] update pxbbq deployment version

### 0.2.3 - 9/3/2024 CC
# - [x] fix bbqbookkeeper nginx config
# - [x] add test OCP route. Examples in demo challenge
# - [x] release ocp cluster. Not sure this is needed, but...
# - [x] fix firewall so it works with async
# - [x] ocp auto completion


### 0.2.4 - CC and ES 9/13/2024
# - [x] add INSTRUQT_USER_EMAIL variable to support PDS - The email address is rarely there
# - [x] add rancher server dns name to route 53
# - [x] use let's encrypt for rancher server <- Doesn't work and was reverted, see relevent code comments
# - [x] fix grafana in kubecon2024 track
# - [x] moved AWS_DNS_ZONE_ID to global vars
# - [x] fixed ssh config logic for async dr
# - [x] update pxbackup verions
# - [x] debug default changed, use the feature flag funcion to flip the bit
# - [x] added grafana_install function to the kubecon meta function
# - [x] add create_sa_and_kubeconfig function and configure clusterpair function

### 0.2.5 - 10/1/2024 CC

# - [x] add seperate function to install portworx operator
# - [x] enabled user workload monitoring in ocp_config function
# - [x] add cert-manager operator for let's encrypt
# - [x] configured certificates for ingress
# - [x] removed try function from aws CLI commands to stop secret leak to logs
# - [x] changed openshift virtualization to use the try function for the retry mechanic
# - [x] updated openshift to 4.16
# - [x] updated openshift operator
# - [x] move cert-manager manifests to seperate functions to clean up script logic and allow retries
# - [x] use try function for osv install to retry instead of sleep timers
# - [x] add OCP PX plugin 
# - [ ] Rancher tracks are borked, use v0.2.4 for now
# - [x] added ocp_config_post_pxe function to install portworx after the pxe install
# - [x] Changed the default storage class to deselect the GCP provided storage class
# - [x] Increment OCP version to 4.16.15
# - [x] added hyperconverged overhead spec


### 0.2.6 - 10/3/2024 CC
# - [x] added meta_gcp_ocp_pxb function
# - [x] revert rancher ssl config
# - [x] add get_ubuntu_image function This populates the UBUNTU_VERSION variable
# - [x] add feature_OCP_SUPPRESSWARNINGS flag
# - [x] wrote OCP specific minio_install configs
# - [x] fixed agent command env vars that were causing .bashrc issues
# - [x] optimized meta_gcp_ocp_pxe function order
# - [x] openshift-install command is now using the try function

### 0.2.7 - 10/9/2024 TD and CC
# - [x] Add a timeout logic to wait_ready functions
# - [x] Parameterize the gke_create_cluster function ?!? This will require rewrites of dependencies and children. It would mean less code for async and migration
# - [x] add wait_ready_ocp-px-operator to meta_gcp_ocp_pxe function (TD)
# - [x] changed cert-manager cluster issuer to zerossl
# - [x] openshift-install command now respects debug flag
# - [x] patching the OCP ingress is now handled by try
# - [x] updated openshift version to 4.16.16
# - [x] Moved cert-manager install to ocp_config
# - [x] added ocp_osv_install function (was previously in OCP config) to reduce delays
# - [x] removed ocp_portworx_operator_install function sleep timer
# - [x] Changed the logv2 function to include a phase parameter
# - [x] Tried to make the primary function logging consistent and added phase so we can grep logs to determine times
# - [x] misc comment and log cleanup

### 0.2.8 - 11/5/24

# - [x] update K8SVERSION and GKE_VERSION to use 1.28
# - [x] merge v0.2.0.1 changes in to this script
# - [x] adjust osv disk size (there is a 500gb quota limit?!?)
# - [x] Updated openshift to 4.16.19
# - [x] changed portworx version to 3.1.6
# - [ ] added pxbbq-mongo-vm.yaml config to work with OSV, this is gated behind the feature_OCP flag
# -    This is a WIP as the manifests do not work. It will be pushed to 2.9
# - [x] add ocp_config_post function. Currently install virtctl
# - [x] split out rancher control-plane

### 0.2.9 - 11/6/24
# - [x] Support upgradeable clusters. Add "upgradeable" to portworx_install() to use N-1 from PX_VERSION set as PX_VERSION_UPGRADEFROM
# - [x] Add meta_gke_portworx_clouddrives_upgradeable to use portworx_install() with upgradeable=true

### 0.2.10 - 11/7/24
# - [x] add stream functionality to nginx

### 0.2.11 - 11/7/24
# - [x] change util server to 33gb ssd

### FUTURE
# - [ ] create gcp_utilserver_rancher_k3s to use k3s, this is to replace gcp_utilserver_rancher


#################################################################
# Todo log

# - [ ] minor: might be worth figuring out the kubectl download logic
# - [ ] for a 1.0 release, we should re-write with parameters
# - [ ] context should be explicit
# - [ ] re-write cleanup-cloud-client with modern scripting convensions

##### Please read the comments carefully!!!

#################################################################
# Conventions and examples:
#
# Writing .bashrc:
#  add_bashrc "export K8SVERSION=${K8SVERSION}"
# This populates an array that will be written to BASHRC at the end of the script

# Using try:

# ARGUMENTS: The first argument is the command you should run. This can be enclosed in ' ' or " ". See the important notes section.

# Flags:
  # retry=1           the number of times we should attempt the command
  # term=true        should we terminate the script if the command fails?
  # gcp=false         should we remove the first region from the GCP_REGIONS array on failure?
  # fail=false        for debugging, forces the command to fail to test retry logic
  # wait=1            the number of seconds to wait between retries

# Example: We want to run a gcloud create command that may fail, and use dynamic zone and region variables
#       This is obviously a fake command
# try 'gcloud create cluster --region ${GCP_REGIONS[0]} --zone ${zones[0]} --zone ${zones[1]}' retry=3 term=false gcp=true
# The above would run the command with proper variable substitution (even though we are using ' instead of ")
# It would try 3 times, not terminate on failure, and remove the first region in the GCP_REGIONS array on failure

# Important Notes:

# Command substitution (GCP=$(SOME COMMAND STRING)) can be done, but it break the simulate functionality. 
# Try doesn't have to be used for every command, and usually isn't required for looping logic etc.
# But any command the should exit on a non-zero exit code should use try
# Try also has the advantage of having robust logging.


# A word about quotations with try:
# try can accept ' ' as it uses the eval command to execute code. 
# This is done so that variables passed to try can be changed based on internal logic. Currently, this applies to:
# - GCP region and zone variables.
# - the K8SVERSION variable

# BUT escape characters do not pass correctly for logging output when using ' '. For example:
# try 'curl -L -s -o px-spec.yaml "https://install.portworx.com/${PXVERSION}?operator=true&mc=false"' will cause the the debugging output
# to only display up to the &. The command is passing correctly, but the debug output is not. This is a limitation of the script.
# This is caused by using ' ' instead of " ". 
# ' ' is required to pass variables that will be evaluated later, which is required for the GCP region logic and K8SVERSION logic.
# Here is a handy reference: https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html#Double-Quotes


#####################
# Function names should be in snake_case
# <cloud>_<verb>_<object>

# For functions that do not have a specific cloud:
# <verb>_<object>

# wait_ready_<object> should be used to wait for a service to be ready

# Functions exist in one of a few categories:
# 1. Primary Functions - These are the main functions that do a set amount of work. Each one should only run once and have logic to check if it has already run
# 2. Helper Functions - These are functions that are called by other functions. They include the wait_ready scripts, which halts execution until a condition is met
# 3. Standard Functions - These are standard functions in every scrit: terminate, log, debug, try
# 4. META Functions - These functions can run workflows, they should consist of more than one primary and helper function.
# 5. Write file functions - These functions should write a single file

##### Logging
# debug logging is controlled by the DEBUG variable. If set, any instance of debug "log massage" will output the message.
# log "log message" will always output the message
# logv2 "log message" will output a banner and CR before the message. Use this at the beginning of functions


#################################################################
# Configuration Section
# Enabled the debug function to output

DEBUG=0

# This script will not run properly with set -eo pipefail as we are planning on having commands fail, use the try function instead
# set -x will output WAAAY too much for this script, use DEBUG=1 instead
#set -x

# Sets the try function set to simulate mode
# SIMULATE=0
# Commenting out the simulate line allows us to run the command with:
# SIMULATE=1 ./script.sh


###########
# Error Codes
readonly ERR_DEFAULT=1
readonly ERR_TRY_FAILED=160
readonly ERR_NO_GCP_REGIONS_LEFT=161
readonly ERR_OCP_FEATURE_FLAG=162
readonly ERR_AWS_FEATURE_FLAG=163

###########
# Global Variables

SSH_ID_NAME="/root/.ssh/id_rsa_instruqt"
SSH_ID_NAME_PUB="${SSH_ID_NAME}.pub"
OCP_INSTALL_DIR="/root/ocp-install"
OCP_VERSION="4.16.19"
PXBACKUP_VERSION="2.7.3"
PXBACKUP_SC="px-csi-db"
GKE_CLUSTERNAME="portworx-cluster"
GKE_CLUSTERNAME_DR="portworx-cluster-dr"
PX_CLUSTERNAME="px-cluster"
PX_VERSION="3.1.6"
PX_VERSION_UPGRADEFROM="3.1.5"
AWS_DNS_ZONE_ID="Z00903771OQIK90QR7LAA"

# This is a tricky variable. If the GCP feature flag is enabled, it will be updated with the stable release of GKE within the region, based 
# on the major.minor version of GKE_VERSION
# If it is not enabled, it can be overridden by rancher, but not before this version of kubectl is installed. This is important because it does
# not directly control the rancher version, which is set by the RANCHER_K8S_Version variable. Honestly this variable should not have a value initially, but we need something
# set to know what version of kubectl to download in the absence of the GCP flag
K8SVERSION="1.28.14"

GKE_VERSION="1.28"
BASHRC_FILE="/root/.bashrc"
MINIO_VERSION="5.2.0"
MINIO_SC="px-csi-db"
UTILVM_NAME="util1"
RANCHER_VERSION="v2.9-023781e52103c45a9bbdf3cb47d60b9336321daa-head"
RANCHER_PASSWORD="gr9o3rNpvgrc6lpA"
RANCHER_SERVER_CONTEXT="rancher"
RANCHER_K8S_VERSION="v1.28.11+rke2r1"
RANCHER_CLUSTER_NAME="cluster1"
UBUNTU_IMAGE_NAME="ubuntu-2204-jammy-v" # this image name is updated by get_ubuntu_image function


# This is the amount of loop interations before we break. 10 sec per loop
WAIT_READY_TIMEOUT=50


# Global Vars set at runtime
SSH_ID_PUB=""

#################################################################
# Cloud Declaration 
# Depricated in favor of feature flags

# The above variable sets the cloud for specific functions, such as installing gcp utilities
# NOTE that the try function needs its own variable passed to start the gcp retry logic

# GCP ZONE Logic
# We will always use GCP_REGIONS[0]. Failures will result in an unset GCP_REGIONS[0]
# This means that zones cannot have spaces
declare -a GCP_REGIONS=("us-central1" "us-west1" "us-east1")
declare -A GCP_ZONES=( \
    ["us-central1"]="us-central1-a us-central1-b us-central1-c"\ 
    ["us-west1"]="us-west1-a us-west1-b us-west1-c"\
    ["us-east1"]="us-east1-b us-east1-c us-east1-d"\
    )

# We will populate the following varables to be used, NOTE that these variables are updated by the try function and are safe to use in your functions
region="${GCP_REGIONS[0]}"

read -a zones <<< "${GCP_ZONES[${region}]}"


#################################################################
# Feature Flags
# these are used to gate certain features in the script to speed up the process. They are mostly harmless to enable, but if you don't need them, setting them to false will speed up the script.
feature_OCP=false
feature_GCP=true
feature_AWS=false
feature_GKE=true
feature_MINIO=false
feature_CONFIGPXBACKUP=false
feature_DUMMY=false
feature_GRAFANA=false
feature_OCP_SUPPRESSWARNINGS=true

# These feature flags are changed in two places so far:
# 1. The conf.sh file for TSCC
# 2. The var substitution area of def file in the challenge library.

# When should you use a feature flag? When you want to change a configuration for a TRACK, OR, to have a premutation to speed up startup times
# Feature flags should also be MOSTLY harmless. Don't have enabling a feature flag install OCP for instance, instead have it insteall utils.
#################################################################
# Test functions

# The bellow ENV VAR is provided by instruqt under most circumstances
if [[ SIMULATE == 1 ]]; then
  log "Simulating, we will now set fake credentials"
  INSTRUQT_GCP_PROJECT_GCPPROJECT_SERVICE_ACCOUNT_KEY="heaut382u8e9aeu89aeguao9jbj89eaue89aue89aueao89a7u9e8"
fi


#################################################################
# Standard Functions

log () {
    echo $(date -u +"%Y-%m-%dT%H:%M:%SZ") "${@}"
}

logv2 () {
  # Requires log
  # This adds a banner and CR to the end of the log. Use this at the beginning of functions
  local log="${1}"
  shift
    while [[ "$1" != "" ]]; do
      PARAM=$(echo $1 | cut -d'=' -f1)
      VALUE=$(echo $1 | cut -d'=' -f2)
      case $PARAM in
        phase)
          local phase="${VALUE}"
          ;;
      esac
      shift
    done
    local func=${FUNCNAME[1]}
    local banner=${banner:-true}
    if [[ ${banner} == true ]]; then
      log ""
      log "########### ${phase} - ${func} - $(date -u +"%Y-%m-%dT%H:%M:%SZ") ###########"
    fi
    log "$log"
    log ""
}

debug () {
  if [[ ${DEBUG} == 1 ]]; then
    echo $(date -u +"%Y-%m-%dT%H:%M:%SZ") "${@}"
  fi
}

terminate () {
  local msg="${1}"
  local code="${2:-1}"
  echo "Error: ${msg}" >&2
  exit "${code}"
}

try () {
  
  log ""
  log "#### TRY FUNCTION called from ${FUNCNAME[1]} ####"


  # Set variable defaults
  local retry=1
  local term=true
  local gcp=false
  local fail=false
  local wait=1

  # Vars
  log "argument passed: $@"
  local cmd="${1}"
  shift
    while [[ "$1" != "" ]]; do
      PARAM=$(echo $1 | cut -d'=' -f1)
      VALUE=$(echo $1 | cut -d'=' -f2)
      case $PARAM in
        retry)
          local retry="${VALUE}"
          debug "Retry value passed: ${retry}"
          ;;
        term)
          local term="${VALUE}"
          debug "Term value passed: ${term}"
          ;;
        gcp)
          local gcp="${VALUE}"
          debug "GCP value passed: ${gcp}"
          ;;
        fail)
          local fail="${VALUE}"
          debug "Fail value passed: ${fail}"
          ;;
        wait)
          local wait="${VALUE}"
          debug "Wait value passed: ${wait}"
          ;;
      esac
      shift
    done
    debug $(kubectl config get-contexts)

  # While we still have retries remaining
  while [[ ${retry} -gt 0 ]]; do
    # Debug
    debug "VARS:: Retry: ${retry} | Terminate: ${term} | GCP: ${gcp} | Fail: ${fail}"
    if [[ ${fail} == true ]]; then
      log "!!Forcing failure!! on command: $(eval echo \"${cmd}\")"
    fi

    ####### REGION LOGIC
    # Let's make sure we have a region to try, else terminate
    if [[ ${GCP_REGIONS[0]} == "" ]]; then
      terminate "No regions left to try" "${ERR_NO_GCP_REGIONS_LEFT}"
    else
      # We have a region, let's update our zones
      read -a zones <<< "${GCP_ZONES[${GCP_REGIONS[0]}]}"
      debug "zones = ${zones[@]}"
    fi

    debug "Starting Command Block"
    #### CMD BLOCK
    if [[ $SIMULATE == 1 ]]; then 
      debug "SIMULATE var set"
      eval "echo \"Simulating: ${cmd}\""
    else 
      debug "SIMULATE var not set - executing command"
      debug "Running $(eval echo \"${cmd}\")"
      eval "${cmd}"
      exit_code=$?
    fi

    debug "starting exit code evaluation"
    #### EVALUATE EXIT CODE

    debug "Exit Code: ${exit_code}"
    if [[ $exit_code -eq 0 ]] && [[ $fail == false ]]; then
    #### Success Block
      log "Successfully ran"
      return 0

    #### FAILURE BLOCK  
    else
      log "Failed to run: $(eval echo \"${cmd}\")"
      log "exit_code: ${exit_code}"
      retry=$((retry-1))

      ### Should we terminate the script?
      if [[ ${term} == true ]] && [[ ${retry} == 0 ]]; then
        terminate "Failed to run: ${cmd}" "${ERR_TRY_FAILED}"
      fi

      ### Are we messing with GCP Variables that need to be shifted?
      if [[ ${gcp} == true ]]; then
        debug "GCP set to true, removing region from GCP_REGIONS"
        unset GCP_REGIONS[0]
        read -a GCP_REGIONS <<< "${GCP_REGIONS[@]}"
        log "Removed region from GCP_REGIONS"
        log "New GCP_REGIONS: ${GCP_REGIONS[@]}"

        # Rancher's zone updates are automatic as we provided the infrastructure.

        # We need to query the new zone and update the $K8SVERSION variable
        get_gke_release

        # If we have the OCP feature flag set, update our config files with the new zones
        if [[ $feature_OCP == true ]]; then
          log "OCP flag set - Updating OCP Install Config with new zones"
          # We need to refresh the directories as the installer will not clean up after itself. It also consumes the install-config.yaml file
          write_ocp_install_config
        fi
      fi
    fi
    # Just to ensure we don't hammer the API
    sleep ${wait}

  done
  log ""
}
meta_gcp_ocp_pxb () {
  logv2 "Running workflow $FUNCNAME[0]" phase="META"

  # Disable nginx customization
  write_nginx_config_ran=true

  ocp_create_cluster
  ocp_config
  ocp_portworx_operator_install
  wait_ready_ocp-px-operator
  portworx_install auth=false encrypt=false clouddrives=true bypass_requirements=true
  ocp_ssl_config
  ocp_osv_install
  wait_ready_portworx
  ocp_config_post_pxe
  ocp_config_post
  portworx_install_storkctl
  alias_pxctl auth=false
  pxbackup_install
  minio_install
  wait_ready_minio
  minio_config
  wait_ready_pxbackup
  pxbackup_config

  oc project default


  log "$FUNCNAME[0] Workflow Complete"

}
ocp_config () {

  # This function configures OCP
  # It installs the portworx operator
  # It also installs the openshift virtualization operator
  # It configures the firewall to allow portworx traffic (by opening up all ports)
  # It is also responsible for the kubeconfig update
  # It also installs cert-manager

  if [[ $ocp_config_ran == true ]]; then
    log "${FUNCNAME[0]} has already run, skipping"
    return 0
  fi

  logv2 "Configuring OCP" phase="START"
  log "resolving requirements"
  ### Requirements
  ocp_create_cluster
  write_ocp_ssl
  write_ocp_px_operator_subscription
  write_ocp_px_operatorgroup
  write_ocp_portworx_role
  write_ocp_osv


  ### Update bashrc
  add_bashrc "export KUBEADMIN_PASSWORD=$(cat ${OCP_INSTALL_DIR}/auth/kubeadmin-password)"
  export KUBECONFIG="${OCP_INSTALL_DIR}/auth/kubeconfig"
  add_bashrc "export KUBECONFIG=${KUBECONFIG}"
  add_bashrc "alias kubectl=/root/kubectl"
  add_bashrc "source <(/root/oc completion bash)"
  add_bashrc "export OCP_CONSOLE_URL=https://console-openshift-console.apps.ocp.${OCP_DNS_ZONE}"
  add_bashrc "export OCP_DNS_ZONE=${OCP_DNS_ZONE}"

  oc completion bash > /etc/bash_completion.d/oc_bash_completion

  ### Update the kubeconfig
  mkdir /root/.kube
  cp -rfv /root/ocp-install/auth/kubeconfig /root/.kube/config
  sleep 5

  ### Configure Firewall
  # Get the OCP network name
  OCP_NETWORK=$(gcloud compute networks list --filter="name ~ ^ocp" --format="value(name)")

  # Open up the firewall
  # This rule must be manual removed by the cleanup script, otherwise the cluster destroy will fail
  gcloud compute firewall-rules create allow-all-ports \
    --direction=INGRESS \
    --priority=999 \
    --network=$OCP_NETWORK \
    --action=ALLOW \
    --rules=all \
    --source-ranges=0.0.0.0/0


### Suppress warnings using the oc command
# ocp will generate some warning by default due to depricated CRDs, this adds a function
# to the bashrc file that redirects the output of the oc command to /dev/null
if [[ $feature_OCP_SUPPRESSWARNINGS == true ]]; then
  cat << EOF >> /root/.bashrc
oc() {
    command oc "$@" 2>/dev/null
}
ocp_portworx_operator_install () {

  ### This function installs the portworx operator for openshift
  # It is a separate function because the operator is installed from the marketplace

  if [[ $ocp_portworx_operator_install_ran == true ]]; then
    log "${FUNCNAME[0]} has already run, skipping"
    return 0
  fi
  logv2 "Installing Portworx Operator on OCP" phase="START"
  log "resolving requirements"
  # Requires:
  ocp_config

  oc create namespace portworx
  oc apply -f /root/ocp-px-operatorgroup.yaml
  oc apply -f /root/ocp-px-operator-subscription.yaml

  ocp_portworx_operator_install_ran=true

  logv2 "Installing Portworx Operator on OCP" phase="END"

}
wait_ready_ocp-px-operator () {
  declare -i timer=0
  logv2 "Waiting for the OCP Portworx Operator to be ready" phase="WAIT_START"
  if [[ $SIMULATE == 1 ]]; then log "Simulating, ${FUNCNAME[0]}";return 0; fi
  until [[ `kubectl -n portworx get pods -l name=portworx-operator | grep Running | grep 1/1 | wc -l` -eq 1 ]]; do
    echo "."
    sleep 10
    if [[ $timer -gt $WAIT_READY_TIMEOUT ]]; then
      logv2 "Timeout waiting for ${FUNCNAME[0]}" phase="WAIT_ERROR"
      break
    fi
    debug "timer value: ${timer}"
    timer+=1
  done
  logv2 "OCP Portworx Operator is ready" phase="WAIT_END"
}
portworx_install () {

  # This function may be called more than once by resetting the portworx_install_ran variable
  # This is only the case for DR meta functions. See the appropriate meta function for more information
  # This function is a unified function that accepts parameters to enable or disable certain features
  # It is sutable for installing portworx on GKE, Rancher or Openshift
  # The detection logic is automatic, but should be understood by the user

  if [[ $portworx_install_ran == true ]]; then
    log "${FUNCNAME[0]} has already run, skipping"
    return 0
  fi

  logv2 "Installing Portworx" phase="START"



  # PARAM BLOCK:
  debug "$@"
  local cmd="${1}"
  # Set variable defaults  
  auth=false
  encrypt=false
  clouddrives=false
  bypass_requirements=false
  upgradeable=false
  shift
    while [[ "$1" != "" ]]; do
      PARAM=$(echo $1 | cut -d'=' -f1)
      VALUE=$(echo $1 | cut -d'=' -f2)
      case $PARAM in
        auth)
          local auth="${VALUE}"
          debug "Auth: ${auth}"
          ;;
        encrypt)
          local encrypt="${VALUE}"
          debug "Encrypt: ${encrypt}"
          ;;
        clouddrives)
          local clouddrives="${VALUE}"
          debug "Cloud Drives: ${clouddrives}"
          ;;
        bypass_requirements)
          local bypass_requirements="${VALUE}"
          debug "Bypass Requirements: ${bypass_requirements}"
          ;;
        upgradeable)
          local upgradeable="${VALUE}"
          debug "Upgradeable Cluster: ${upgradeable}"
          ;;
      esac
      shift
    done
if [[ $bypass_requirements == false ]]; then
  # Requires:
  portworx_install_operator
  wait_ready_portworx_operator
fi

if [[ $upgradeable == true ]]; then
  # Portworx gets installed with a version that can be 
  # upgraded, stored in PX_VERSION_UPGRADEFROM
  # where you can upgrade to PX_VERSION
  # we want the operator to get PX_VERSION
  # since upgrades need latest compared to upgrade
  log "Making Portworx Install Upgradeable using $PX_VERSION_UPGRADEFROM"
  PX_INSTALL_VERSION=$PX_VERSION_UPGRADEFROM
else
  log "Upgradeable not set, using $PX_VERSION"
  PX_INSTALL_VERSION=$PX_VERSION
fi
  # Download the spec file
  # Be warned, the escape characters are nasty here:
  if [[ $clouddrives == true ]]; then
    log "Enabling Cloud Drives"
    echo $INSTRUQT_GCP_PROJECT_GCPPROJECT_SERVICE_ACCOUNT_KEY | base64 -d > gcloud.json
    kubectl -n portworx create secret generic px-gcloud --from-file=gcloud.json
    try "curl -L -s -o px-spec.yaml \"https://install.portworx.com/${PX_INSTALL_VERSION}?operator=true&mc=false&kbver=${K8SVERSION}&ns=portworx&b=true&iop=6&s=%22type%3Dpd-standard%2Csize%3D50%22&ce=gce&c=${PX_CLUSTERNAME}&gke=true&stork=true&csi=true&mon=true&tel=false&st=k8s&promop=true\""
    yq -iy '.spec.volumes += [{"name": "gcloud", "mountPath": "/etc/pwx/gce", "secret": {"secretName": "px-gcloud"}}] | .spec.env += [{"name": "GOOGLE_APPLICATION_CREDENTIALS", "value": "/etc/pwx/gce/gcloud.json"}]' px-spec.yaml
  else
    try "curl -L -s -o px-spec.yaml \"https://install.portworx.com/${PX_INSTALL_VERSION}?operator=true&mc=false&kbver=${K8SVERSION}&ns=portworx&b=true&s=%2Fdev%2Fsdb&j=auto&c=${PX_CLUSTERNAME}&gke=true&stork=true&csi=true&mon=true&tel=false&st=k8s&promop=true\""
  fi

  #Due to really wanting only a single function, we need to strip out gke=true IF we are on rancher. We can tell because our K8SVERSION var will end in rke2r1
  if [[ $K8SVERSION == *rke2r1 ]]; then
    log "Removing gke=true from px-spec.yaml"
    yq -iy 'del(.metadata.annotations["portworx.io/is-gke"])' px-spec.yaml
  fi
  if [[ $ocp_config_ran == true ]]; then
    log "OCP detected, removing gke=true and adding is-openshift=true"
    yq -iy 'del(.metadata.annotations["portworx.io/is-gke"])' px-spec.yaml
    yq -iy '.metadata.annotations["portworx.io/is-openshift"] = "true"' px-spec.yaml
  fi


  if [[ $auth == true ]]; then
    log "Enabling Authentication"
    # enable security
    yq -i '.spec.security.enabled = true' px-spec.yaml
    # disable checks due to https://portworx.atlassian.net/browse/PWX-32111?atlOrigin=eyJpIjoiN2M1NTFiZTY3MTVkNDkwMTliNmM4Zjc0MDY2ODhjZmEiLCJwIjoiamlyYS1zbGFjay1pbnQifQ
    yq -i '.metadata.annotations."portworx.io/preflight-check" = "skip"' px-spec.yaml
    # disable guest access
    yq -i '.spec.security.auth.guestAccess = "Disabled"' px-spec.yaml
  fi

  if [[ $encrypt == true ]]; then
    # enable encryption
    log "Enabling Encryption"
    # WIP
  fi

  try 'kubectl apply -f px-spec.yaml'

  sleep 20

  kubectl patch stc px-cluster --type='json' -p='[
  {"op": "add", "path": "/metadata/annotations/portworx.io~1service-type", "value": "portworx-api:LoadBalancer"},
  {"op": "add", "path": "/spec/stork/args/admin-namespace", "value": "portworx"}
  ]' -n portworx 


  portworx_install_ran=true

  logv2 "Installing Portworx" phase="END"
}
wait_ready_portworx () {
  declare -i timer=0
  logv2 "Waiting for portworx to be ready" phase="WAIT_START"
  if [[ $SIMULATE == 1 ]]; then log "Simulating, ${FUNCNAME[0]}";return 0; fi
  until [[ $(kubectl -n portworx get stc -o jsonpath='{.items[0].status.phase}' 2> /dev/null) == "Running" ]]; do
      echo "."
      sleep 10
    if [[ $timer -gt $WAIT_READY_TIMEOUT ]]; then
      logv2 "Timeout waiting for ${FUNCNAME[0]}" phase="WAIT_ERROR"
      break
    fi
    debug "timer value: ${timer}"
    timer+=1
  done
  logv2 "Portworx is ready" phase="WAIT_END"
}
ocp_config_post_pxe () {

  ### This function is designed to run AFTER portworx is installed. 
  # it currently enables the console plugin and sets the px-csi-db storage class to be the default

  if [[ $ocp_config_post_pxe_ran == true ]]; then
    log "${FUNCNAME[0]} has already run, skipping"
    return 0
  fi

  logv2 "Configuring OCP Post PXE" phase="START"
  log "resolving requirements"
  # Requires

   # Enable the console plugin
cat << EOF | oc apply -f -
apiVersion: operator.openshift.io/v1
kind: Console
metadata:
  name: cluster
spec:
  plugins:
    - portworx
EOF

  # Enable the px-csi-db storage class to be the default
  kubectl patch storageclass px-csi-db -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'

ocp_config_post_pxe_ran=true

logv2 "Configuring OCP Post PXE" phase="END"

}
portworx_install_storkctl () {
  if [[ $portworx_install_installstorkctl_ran == true ]]; then
    log "${FUNCNAME[0]} has already run, skipping"
    return 0
  fi

  logv2 "Installing StorkCTL" phase="START"
  log "resolving requirements"
  # Requires:
  portworx_install
  wait_ready_portworx

  STORK_POD=$(kubectl get pods -n portworx -l name=stork -o jsonpath='{.items[0].metadata.name}')
  try "kubectl cp -n portworx $STORK_POD:storkctl/linux/storkctl ./storkctl  --retries=10"
  chmod +x storkctl
  mv storkctl /usr/bin/storkctl
  portworx_install_installstorkctl_ran=true
 
  logv2 "Installing StorkCTL" phase="END"

}
minio_install () {
  if [[ $minio_install_ran == true ]]; then
    log "${FUNCNAME[0]} has already run, skipping"
    return 0
  fi

  logv2 "Installing Minio" phase="START"
  log "resolving requirements"
  # Requires:
  install_utilities
  # Portworx installed. We don't have a specific requirement because we may have used 1 of 2 installs

if [[ $ocp_config_ran == true ]]; then

  oc create ns px-minio
  oc create sa scc-admin -n px-minio
  oc adm policy add-cluster-role-to-user cluster-admin -z scc-admin -n px-minio

cat << EOF | oc apply -f -
apiVersion: batch/v1
kind: Job
metadata:
  name: pre-install-scc
  namespace: px-minio
  annotations:
    "helm.sh/hook": pre-install
spec:
  template:
    spec:
      serviceAccountName: scc-admin
      containers:
      - name: add-scc-anyuid
        image: registry.access.redhat.com/openshift3/ose-cli
        command: ["/bin/bash", "-c"]
        args:
          - >
            oc adm policy add-scc-to-user anyuid -z minio-sa;
            echo "SCC anyuid granted";
      restartPolicy: OnFailure
EOF
fi
  helm repo add minio https://charts.min.io/ && helm repo update


  try "helm install px-minio \
      --set mode=standalone \
      --set persistence.storageClass=${MINIO_SC} \
      --set persistence.size=10Gi \
      --set resources.requests.memory=1Gi \
      --set service.type=LoadBalancer \
      --namespace px-minio \
      --version ${MINIO_VERSION} \
      --create-namespace \
      minio/minio"
  

  oc project default
  minio_install_ran=true
  logv2 "Installing Minio" phase="END"
}
wait_ready_minio () {
  declare -i timer=0
  logv2 "Waiting for Minio to be ready" phase="WAIT_START"
  if [[ $SIMULATE == 1 ]]; then log "Simulating, ${FUNCNAME[0]}";return 0; fi
  until [[ $(kubectl -n px-minio get deployments.apps px-minio -o json | jq -r '.status.readyReplicas') -le 2 ]]; do
    echo "."
    sleep 10
    if [[ $timer -gt $WAIT_READY_TIMEOUT ]]; then
      logv2 "Timeout waiting for ${FUNCNAME[0]}" phase="WAIT_ERROR"
      break
    fi
    debug "timer value: ${timer}"
    timer+=1
  done
  logv2 "Minio is ready" phase="WAIT_END"
  declare -i timer=0
  logv2 "Waiting for Minio IP to be ready"  phase="WAIT_START"
  ip_regex='^([0-9]{1,3}\.){3}[0-9]{1,3}$'
  until [[ $(kubectl -n px-minio get svc px-minio -o json | jq -cr '.status.loadBalancer.ingress[0].ip') =~ $ip_regex ]]; do 
    echo "."
    sleep 10
    if [[ $timer -gt $WAIT_READY_TIMEOUT ]]; then
      logv2 "Timeout waiting for ${FUNCNAME[0]}" phase="WAIT_ERROR"
      break
    fi
    debug "timer value: ${timer}"
    timer+=1
  done
  # I don't remember why this is here
  sleep 10
  logv2 "Minio IP is ready" phase="WAIT_END"
}
minio_config () {
  if [[ $minio_config_ran == true ]]; then
    log "${FUNCNAME[0]} has already run, skipping"
    return 0
  fi

  logv2 "Configuring Minio" phase="START"
  log "resolving requirements"
  # Requires:
  install_utilities
  minio_install
  wait_ready_minio
  
  MINIO_ENDPOINT=http://$(kubectl get svc -n px-minio px-minio -o jsonpath='{.status.loadBalancer.ingress[].ip}'):9000
  MINIO_ACCESS_KEY=$(kubectl get secret -n px-minio px-minio -o jsonpath="{.data.rootUser}" | base64 --decode)
  MINIO_SECRET_KEY=$(kubectl get secret -n px-minio px-minio -o jsonpath="{.data.rootPassword}" | base64 --decode)
  BUCKETNAME=instruqt-$(date +%s)
  BUCKETNAME_OBJECTLOCK=instruqt-$(date +%s)-objectlock

  try "mc alias set px $MINIO_ENDPOINT $MINIO_ACCESS_KEY $MINIO_SECRET_KEY" retry=3 term=false wait=15

  try "mc mb px/$BUCKETNAME" retry=3
  try "mc mb px/$BUCKETNAME_OBJECTLOCK --with-lock" retry=3 wait=5
  try "mc retention set --default COMPLIANCE 7d px/${BUCKETNAME_OBJECTLOCK}" term=false retry=3 wait=5

  add_bashrc "export MINIO_ENDPOINT=${MINIO_ENDPOINT}"
  add_bashrc "export MINIO_ACCESS_KEY=${MINIO_ACCESS_KEY}"
  add_bashrc "export MINIO_SECRET_KEY=${MINIO_SECRET_KEY}"
  add_bashrc "export BUCKETNAME=${BUCKETNAME}"
  add_bashrc "export BUCKETNAME_OBJECTLOCK=${BUCKETNAME_OBJECTLOCK}"

  
  minio_config_ran=true
  logv2 "Configuring Minio" phase="END"
}
pxbackup_install () {
  # This function installs PX-Backup.
  # This function does not configure PX backup and does not require minio (becasue you
  # could be bringing your own object config)

  if [[ $pxbackup_install_ran == true ]]; then
    log "${FUNCNAME[0]} has already run, skipping"
    return 0
  fi

  logv2 "Installing PX-Backup" phase="START"
  log "resolving requirements"
  # Requires:
  install_utilities
  # A working cluster!!
  # portworx enterprise due to our storage class


  try "helm repo add portworx http://charts.portworx.io/ && helm repo update"
  try "helm install px-central portworx/px-central --namespace central --create-namespace --version ${PXBACKUP_VERSION} --set persistentStorage.enabled=true,persistentStorage.storageClassName=\"${PXBACKUP_SC}\",pxbackup.enabled=true,oidc.centralOIDC.updateAdminProfile=false"

  # NOTE, these commands will run async. This is by design, but any configuration funciton (or perhaps the meta
  # funcions) should wait for the pxbackup pods to be ready before continuing by using wait_ready_pxbackup

  
  pxbackup_install_ran=true

  logv2 "Installing PX-Backup" phase="END"

}
wait_ready_pxbackup () {
  declare -i timer=0
  logv2 "Waiting for px-backup to be ready" phase="WAIT_START"
  if [[ $SIMULATE == 1 ]]; then log "Simulating, ${FUNCNAME[0]}";return 0; fi
  until [[ $(kubectl get po --namespace central --no-headers -ljob-name=pxcentral-post-install-hook  -o json | jq -rc '.items[0].status.phase') == "Succeeded" ]]; do
      echo "Waiting for post-install hook to succeed..."
      sleep 10
    if [[ $timer -gt $WAIT_READY_TIMEOUT ]]; then
      logv2 "Timeout waiting for ${FUNCNAME[0]}" phase="WAIT_ERROR"
      break
    fi
    debug "timer value: ${timer}"
    timer+=1
  done
  logv2 "px-backup is ready" phase="WAIT_END"
}
pxbackup_config () {

  if [[ $pxbackup_config_ran == true ]]; then
    log "${FUNCNAME[0]} has already run, skipping"
    return 0
  fi

  logv2 "Configuring PX-Backup" phase="START"
  log "resolving requirements"
  # Requirements
  pxbackup_install
  minio_install
  wait_ready_minio
  wait_ready_pxbackup
  config_minio
  pxbackup_pxbackup_installctl

  # Set the load balancer
  kubectl patch svc px-backup -n central --type='json' -p '[{"op":"replace","path":"/spec/type","value":"LoadBalancer"}]'
  wait_ready_pxbackup_loadbalancer

  LB_UI_IP=$(kubectl get svc -n central px-backup-ui -o jsonpath='{.status.loadBalancer.ingress[].ip}')
  LB_SERVER_IP=$(kubectl get svc -n central px-backup -o jsonpath='{.status.loadBalancer.ingress[].ip}')
  client_secret=$(kubectl get secret --namespace central pxc-backup-secret -o jsonpath={.data.OIDC_CLIENT_SECRET} | base64 --decode)
  add_bashrc "export LB_UI_IP=${LB_UI_IP}"
  add_bashrc "export LB_SERVER_IP=${LB_SERVER_IP}"
  add_bashrc "export CLIENT_SECRET=${client_secret}"

  # If we are running openshift, we need to create a kubeconfig file
  # Why did we use the ocp_config_ran variable instead of the feature flag? Because this change is destructive


  # And login to px backup
  until [[ $return_value == 0 ]]; do
      pxbackupctl login -s http://$LB_UI_IP -u admin -p admin
      return_value=$?
      echo "Waiting for successful login"
      sleep 5
  done
  # Do we have the feature flag to configure pxbackup?
  if [[ $feature_CONFIGPXBACKUP == true ]]; then
    log "Configuring PX-Backup"
    pxbackupctl create cloudcredential --name gcp-account -p google --google-json-key /root/.config/gcloud/credentials -e $LB_SERVER_IP:10002
    cloud_credential_uid=$(pxbackupctl get cloudcredential -e $LB_SERVER_IP:10002 --orgID default -o json | jq -cr '.[0].metadata.uid') 
    
  if [[ $ocp_config_ran == true ]]; then
    log "openshift detected, creating kubeconfig"
    kubectl config view --flatten --minify > /root/gcp-pxbackup-kubeconfig.yaml
    pxbackupctl create cluster --name instruqt-px -k /root/gcp-pxbackup-kubeconfig.yaml -e $LB_SERVER_IP:10002 --orgID default
  else
    log "openshift not detected, creating cluster using default method"
    pxbackupctl create cluster --name instruqt-px -k /root/gcp-pxbackup-kubeconfig.yaml -e $LB_SERVER_IP:10002 --cloud-credential-uid $cloud_credential_uid --cloud-credential-name gcp-account --orgID default
  fi
    # Create our schedule policies
    pxbackupctl create schedulepolicy --interval-minutes 15 -e $LB_SERVER_IP:10002 --name 15-min
    pxbackupctl create schedulepolicy --interval-minutes 15 -e $LB_SERVER_IP:10002 --name 15-min-object --forObjectLock


    # Connect to our minio buckts. This requires that minio was installed and the buckets were created.
    pxbackupctl create cloudcredential --name s3-account -p aws -e $LB_SERVER_IP:10002 --aws-access-key $MINIO_ACCESS_KEY --aws-secret-key $MINIO_SECRET_KEY
    cloud_credential_uid=$(pxbackupctl get cloudcredential -e $LB_SERVER_IP:10002 --orgID default -o json | jq -cr '.[1].metadata.uid') 

    pxbackupctl create backuplocation -e $LB_SERVER_IP:10002 --cloud-credential-Uid $cloud_credential_uid --name backup-location-1 -p s3 --cloud-credential-name s3-account --path $BUCKETNAME --s3-endpoint ${MINIO_ENDPOINT} --s3-region us-central-1 --s3-disable-pathstyle=true --s3-disable-ssl=true
    pxbackupctl create backuplocation -e $LB_SERVER_IP:10002 --cloud-credential-Uid $cloud_credential_uid --name obj-lock-backup-location-1 -p s3 --cloud-credential-name s3-account --path $BUCKETNAME_OBJECTLOCK --s3-endpoint ${MINIO_ENDPOINT} --s3-region us-central-1 --s3-disable-pathstyle=true --s3-disable-ssl=true
  fi

  # Finally, let's update a file with nginx tabs:
cat << EOF > /var/www/html/pxbackup.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>PX Backup Link</title>
</head>
<body>
    <a href="http://${LB_UI_IP}" target="_blank" rel="noopener noreferrer">PX Backup Web Console</a>
</body>
</html>
EOF

  pxbackup_config_ran=true

  logv2 "Configuring PX-Backup" phase="END"
}
