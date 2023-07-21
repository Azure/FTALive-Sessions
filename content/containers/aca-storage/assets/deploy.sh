LOCATION='australiaeast'
PREFIX='aca-storage'
RG_NAME="$PREFIX-rg"
ACA_ENV="$PREFIX-env"
ACA_APP="$PREFIX-storage-demo"
STORAGE_ACCOUNT_UNIQUE_ID=`echo -n $RG_NAME | shasum | cut -c1-12`
STORAGE_ACCOUNT_NAME="stor$STORAGE_ACCOUNT_UNIQUE_ID"
FILE_SHARE_NAME='ftalive-demo'
FILE_STORAGE_NAME='my-azure-files'

# create resource group
az group create --location $LOCATION --resource-group $RG_NAME

# create storage account & azure file share
az storage account create --name $STORAGE_ACCOUNT --resource-group $RG_NAME --location $LOCATION --sku Standard_LRS
STORAGE_ACCOUNT_KEY=`az storage account keys list --resource-group $RG_NAME --account-name $STORAGE_ACCOUNT_NAME --query [0].value --output tsv`
az storage share create --name $FILE_SHARE_NAME --account-name $STORAGE_ACCOUNT --account-key $STORAGE_ACCOUNT_KEY

# create container environment & container app
az containerapp env create --name $ACA_ENV --resource-group $RG_NAME --location $LOCATION
az containerapp create --name $ACA_APP --resource-group $RG_NAME --environment $ACA_ENV

# add a volume mount to the container app
az containerapp env storage set \
--name $ACA_ENV \
--resource-group $RG_NAME \
--storage-name $FILE_STORAGE_NAME \
--azure-file-account-name $STORAGE_ACCOUNT_NAME \
--azure-file-account-key $STORAGE_ACCOUNT_KEY \
--azure-file-share-name $FILE_SHARE_NAME \
--access-mode ReadWrite

# read container app configuration
az containerapp show --name $ACA_APP --resource-group $RG_NAME -o yaml > storage-demo.yaml

# copy the contents of ./storage-demo-replace.yaml over the 'containers' section of ./storage-demo.yaml

# update the container app
az containerapp update --name $ACA_APP --resource-group $RG_NAME --yaml storage-demo.yaml

###########################
# Persistence tests
###########################
# open commands below in diferent console instances
az containerapp exec --name $ACA_APP --resource-group $RG_NAME --container container1
az containerapp exec --name $ACA_APP --resource-group $RG_NAME --container container2

###########################
# Container file system
###########################
# container1
mkdir /volumes/container/
touch /volumes/container/test.log
ls /volumes/container/

# container2
ls /volumes/container/ # "ls: cannot access '/volumes/container/'" error returned

###########################
# Temporary storage
###########################
# container1
touch /volumes/temp/test-temp.log

# container2
ls /volumes/temp/

###########################
# Azure File share
###########################
# container1
touch /volumes/azurefile/test-share.log

# container2
ls /volumes/azurefile/

## restart replica
REVISION_NAME=`az containerapp revision list --resource-group $RG_NAME --name $ACA_APP --query [0].name --output tsv`
az containerapp revision restart --resource-group $RG_NAME --name $ACA_APP --revision $REVISION_NAME

# container1
az containerapp exec --name $ACA_APP --resource-group $RG_NAME --container container1
ls /volumes/temp # directory should be empty
ls /volumes/azurefile # should container 'test-share.log' file

# container2
az containerapp exec --name $ACA_APP --resource-group $RG_NAME --container container2
ls /volumes/temp # directory should be empty
ls /volumes/azurefile # should container 'test-share.log' file

###########################
# Performance tests
# I/O benchmarking 
###########################
# connect to container1 using 'exec'
apt-get update && apt-get install fio -y && apt-get install ioping -y

###########################
# Container file system
###########################
fio --filename=/performance.test \
--direct=1 \
--rw=randread \
--bs=4096B \
--ioengine=libaio \
--iodepth=256 \
--runtime=10 \
--numjobs=4 \
--time_based \
--group_reporting \
--name=iops-test-job \
--eta-newline=1 \
--size=1Gi
# READ: bw=37.7MiB/s (39.5MB/s), 37.7MiB/s-37.7MiB/s (39.5MB/s-39.5MB/s), io=377MiB (395MB), run=10002-10002msec

###########################
# Temporary storage
###########################
fio --filename=/volumes/temp/performance.test \
--direct=1 \
--rw=randread \
--bs=4096B \
--ioengine=libaio \
--iodepth=256 \
--runtime=10 \
--numjobs=4 \
--time_based \
--group_reporting \
--name=iops-test-job \
--eta-newline=1 \
--size=1Gi
# READ: bw=76.4MiB/s (80.1MB/s), 76.4MiB/s-76.4MiB/s (80.1MB/s-80.1MB/s), io=765MiB (802MB), run=10013-10013msec

###########################
# Azure file share
###########################
fio --filename=/volumes/azurefile/performance.test \
--direct=1 \
--rw=randread \
--bs=65536B \
--ioengine=libaio \
--iodepth=256 \
--runtime=10 \
--numjobs=4 \
--time_based \
--group_reporting \
--name=iops-test-job \
--eta-newline=1 \
--size=1Gi
# READ: bw=21.6MiB/s (22.7MB/s), 21.6MiB/s-21.6MiB/s (22.7MB/s-22.7MB/s), io=351MiB (368MB), run=16219-16219msec

###########################
# Latency banchmarking
###########################

###########################
# container file system
###########################
ioping /performance.test
# min/avg/max/mdev = 237.6 us / 484.9 us / 1.21 ms / 234.0 us

###########################
# Temporary storage
###########################
ioping /volumes/temp/performance.test
# min/avg/max/mdev = 208.2 us / 863.1 us / 5.07 ms / 897.4 us

###########################
# Azure File share
###########################
ioping /volumes/azurefile/performance.test
# min/avg/max/mdev = 3.77 ms / 32.6 ms / 500.3 ms / 63.6 ms

###########################
# Azure File share with 
# 4kb block size
###########################
fio --filename=/volumes/azurefile/performance.test \
--direct=1 \
--rw=randread \
--bs=4096B \
--ioengine=libaio \
--iodepth=256 \
--runtime=10 \
--numjobs=4 \
--time_based \
--group_reporting \
--name=iops-test-job \
--eta-newline=1 \
--size=1Gi
# READ: bw=3790KiB/s (3881kB/s), 3790KiB/s-3790KiB/s (3881kB/s-3881kB/s), io=41.4MiB (43.4MB), run=11183-11183msec