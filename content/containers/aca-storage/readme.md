# Azure Container Apps Storage

## Overview
In this session you will learn how to work with storage in ACA (Azure Container Apps). 
We will go through available options for your workloads and present a hands-on demo.
Explaining other basic concepts about ACA that is not related to storage is not covered by this session. For that, please refer to ACA Introduction.

  > ⚠️
  > **Note**: The volume mounting features in Azure Container Apps are in preview.

## Agenda
- Available storage options
- Demo
  - Deploy a multi-container app
  - Running persistence tests
    - Container File System
    - Temporary Storage
    - Azure Files Share
  - Running performance tests
  
## Available storage options

A container app has access to different types of storage. A single app can take advantage of more than one type of storage if necessary.

| Storage type | Description | Usage examples |
|--|--|--|
| [Container file system](https://docs.microsoft.com/en-us/azure/container-apps/storage-mounts?pivots=aca-cli#container-file-system) | Temporary storage scoped to the local container | Writing a local app cache. |
| [Temporary storage](https://docs.microsoft.com/en-us/azure/container-apps/storage-mounts?pivots=aca-cli#temporary-storage) | Temporary storage scoped to an individual replica | Sharing files between containers in a replica. For instance, the main app container can write log files that are processed by a sidecar container. |
| [Azure Files](https://docs.microsoft.com/en-us/azure/container-apps/storage-mounts?pivots=aca-cli#azure-files) | Permanent storage | Writing files to a file share to make data accessible by other systems. |

There is a much more detailed explanation about the 3 different types in the official [docs](https://docs.microsoft.com/en-us/azure/container-apps/storage-mounts?pivots=aca-cli)

![ACA Storage diagram](media/aca-storage.png "ACA Storage diagram")

## Demo

In the next steps we will explore all the possible storage options in a Container Apps environment and also run some benchmarks on them.

### Prerequisites

| Requirement | Instructions |
|--|--|
| Azure account | If you don't have one, [create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F). |
| Azure Storage Account | [Create a File Share](https://docs.microsoft.com/en-us/azure/storage/files/storage-how-to-create-file-share?tabs=azure-portal) named "**ftalive-demo**". You can leave all defaults when creating the storage account and the file share |
| az-cli | [Install instructions](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli). Make sure to run "az login" before following the rest of instructions |

### Create the Container Apps Environment

*(If you already have a Container Apps Environment created, you can skip these steps)*

A Container App runs inside a Container Apps Environment. Therefore, the first step before deploying apps is to create the environment. Let's create a new resource group named "rg-academo" and then create a Container Apps Environment in it:

```az-cli
az group create -l eastus -n rg-academo

az containerapp env create --name aca-env --resource-group rg-academo --location eastus
```

The last command will take some minutes to complete because behind the scenes, Azure is provisioning an AKS cluster and all the infrastructure components around it.

### Deploy a multi-container app

Now we have all the necessary components to start our Container App deployments. Let's deploy our first app into the environment (this can also be accomplished using the Portal):

```az-cli
az containerapp create --name storage-demo --resource-group rg-academo --environment aca-env
```

When that az-cli command completes, you should be able to see the Container App "storage-demo" listed in the Portal.

The next step before we setup the containers to have the volume mounts is to configure our Container App Environment to be linked to our Azure Files Share (check the pre-requisites section above). More details on this command can be seen [here](https://docs.microsoft.com/en-us/azure/container-apps/storage-mounts?pivots=aca-cli#configuration-1):

```az-cli
az containerapp env storage set --name aca-env --resource-group rg-academo 
                                --storage-name my-azure-files
                                --azure-file-account-name <STORAGE_ACCOUNT_NAME>
                                --azure-file-account-key <STORAGE_ACCOUNT_KEY>
                                --azure-file-share-name ftalive-demo
                                --access-mode ReadWrite
```

Now we will change the Container App configuration to run two containers in it. The idea is to demonstrate how the different storage scopes apply to different containers and their underlying environment. More details about multi-container support in ACA can be found [here](https://docs.microsoft.com/en-us/azure/container-apps/containers#multiple-containers)
Another thing that we will be doing is to update the configuration to mount both Azure Files and the Temporary Storage into both containers. Currently, this can only be achieved by updating the YAML definition of the Container App, more details [here](https://docs.microsoft.com/en-us/azure/container-apps/storage-mounts?pivots=aca-cli#configuration).

The first step is to save the current Container App configuration as YAML into your local disk:

```az-cli
az containerapp show --name storage-demo --resource-group rg-academo -o yaml > storage-demo.yaml
```

Open the YAML file in your preferred editor and find the group "containers:", and replace by this content:

<details>
  <summary>Expand</summary>
  
```yaml
    containers:
    - args:
      - while true; do sleep 30; done;
      command:
      - /bin/bash
      - -c
      - --
      image: docker.io/ubuntu
      name: container1
      probes: []
      resources:
        cpu: 0.5
        memory: 1Gi
      volumeMounts:
      - mountPath: /volumes/azurefile
        volumeName: azure-files-volume
      - mountPath: /volumes/temp
        volumeName: temporary-volume
    - args:
      - while true; do sleep 30; done;
      command:
      - /bin/bash
      - -c
      - --
      image: docker.io/ubuntu
      name: container2
      probes: []
      resources:
        cpu: 0.5
        memory: 1Gi
      volumeMounts:
      - mountPath: /volumes/azurefile
        volumeName: azure-files-volume
      - mountPath: /volumes/temp
        volumeName: temporary-volume
    revisionSuffix: ''
    scale:
      maxReplicas: 10
      minReplicas: 1
    volumes:
    - name: azure-files-volume
      storageName: my-azure-files
      storageType: AzureFile
    - name: temporary-volume
      storageType: EmptyDir
```
</details>

Save the YAML file and now again the az-cli we need to update the Container App:

```az-cli
az containerapp update --name storage-demo --resource-group rg-academo --yaml storage-demo.yaml
```

What we just did is to deploy two containers running a barebone Ubuntu docker image.
Now, if we go in the Portal, under menu "Containers", we must see two containers within the App. One named "container1" and other named "container2".
Both contains two volume mounts:

| Mount path | Description |
|--|--|
| /volumes/azurefile | This is the [Azure Files](https://docs.microsoft.com/en-us/azure/container-apps/storage-mounts?pivots=aca-cli#azure-files) mount. Writing here is permanent across any container, replicas or Container Apps running in other environments |
| /volumes/temp |  This is the [Temporary Storage](https://docs.microsoft.com/en-us/azure/container-apps/storage-mounts?pivots=aca-cli#temporary-storage) mount. Writing here should only be persisted across the lifecycle of the replica (therefore, shared between the containers within that replica) |

Important: any other path in the container that we write to - for example /volumes/**container**/ - is going to use the internal [Container File system](https://docs.microsoft.com/en-us/azure/container-apps/storage-mounts?pivots=aca-cli#container-file-system)

### Running persistence tests

Let's run some tests by connecting to the containers terminal just to verify everything is working like they're supposed to. 
By the time of this writing, connecting to the Console in the Azure Portal in a specific container in a multi-container setup doesn't work. For that, we can use the az-cli for connect to both:

<sub>For "container1":</sub>
```az-cli
az containerapp exec --name storage-demo --resource-group rg-academo --container container1
````

<sub>For "container2" (open in a new window while keeping container1 window open):</sub>
```az-cli
az containerapp exec --name storage-demo --resource-group rg-academo --container container2
````

To verify both connections are working, just type command "*ls*" and check if you get back the list of root folders in the containers. One of the folders should be named "volumes" in that list.
You're now have two terminal windows open and ready to execute the next steps.

#### Container File System
Remember, in the Container File System the changes are only visible for the local container inside that Container App. The files must not be shared to other containers within the Container App.
Let's verify that by creating a new file named **"test.log"** under /volumes/**container/** under **container1** terminal window:

<sub>Container1:</sub>
```bash
mkdir /volumes/container/
touch /volumes/container/test.log
````

Verify that the file is created by issuing:

<sub>Container1:</sub>
```bash
ls /volumes/container/
````

And you must get back "test.log" from that command.
Now, in **container2**, try to do the same command:

<sub>Container2:</sub>
```bash
ls /volumes/container/
````

You should get an error back saying ***"ls: cannot access '/volumes/container/': No such file or directory"***
This proves that when we create files that are not either in an Azure Files or a Temporary Storage, they are only visible to the local container

#### Temporary Storage
In a Temporary Storage, the files are shared across all containers within the same replica. Remember that when a Container App is scaling up, a new replica with the same set of containers is created. That new replica will not share the same Temporary Storage as the other replicas. So be aware about scaling up scenarios.
Let's create a file under Temporary Storage path in **container1**:

<sub>Container1:</sub>
```bash
touch /volumes/temp/test.log
```

Now let's verify that same file is also visible in **container2**:

<sub>Container2:</sub>
```bash
ls /volumes/temp/
```

In the return from Container2 you should see "test.log" listed there.

#### Azure Files Share
In Azure Files Share, the files are persisted in an external Azure Storage Account which is located outside of Azure Container Apps environments. The expectation here is that any Container App using it will be able to share files, no matter what the app lifecycle is. This test uses a Standard File Share and not Premium performance tier. More on this [here](https://docs.microsoft.com/en-us/azure/storage/files/storage-how-to-create-file-share?tabs=azure-portal#basics).

Let's create a file under Azure Files Share path in **container1**:

<sub>Container1:</sub>
```bash
touch /volumes/azurefile/test.log
```
Now let's verify that same file is also visible in **container2**:

<sub>Container2:</sub>
```bash
ls /volumes/azurefile/
```

Go to Azure Portal -> Storage Accounts -> ***Your storage account name*** -> File shares -> ftalive-demo and verify that "test.log" is also listed there.

#### Restarting the replica
Until now, both Temporary Storage and Azure Files Shares seems to have the same behavior in the tests. Both were able to share files to multiple containers inside the same Container App. But what happens when your app gets restarted for some reason? 
To test that, we need to force a restart of the [revision](https://docs.microsoft.com/en-us/azure/container-apps/revisions). Restarting revisions is not supported by the Azure Portal yet, so we need to use az-cli for that. First, grab the revision name of your Container App by navigating in the Portal to "Revision management". In the right side you should see some name like "storage-demo--******". Copy that name and in a new terminal window, run:

```az-cli
az containerapp revision restart --resource-group rg-academo --name storage-demo --revision <REVISION_NAME>                              
```

After a couple of seconds, both terminals you had connected previously to container1 and container2 will get an error because they got restarted.
Connect to them again and run on both terminals:

```az-cli
ls /volumes/temp/
```

Note there is no "test.log" anymore. The file is gone from the temporary storage because the replica got restarted.
Now let's check the Azure Files folder:

```az-cli
ls /volumes/azurefile/
```

Now we should get back "test.log" from that command. It proves that Azure Files Share storage persists across replica restarts.

### Running performance tests

OK, so how does the different storage types available in Azure Container Apps compare to each other in terms of performance? 

> **Note**: This session purpose is not to provide final numbers for decision making but only to guide you how to run your own benchmarks in your own environments. Results may vary across different regions, SKUs and many other factors, that's why it is very important that you run benchmarks yourself.

####Installing the needed packages
We will use [fio](https://github.com/axboe/fio) and [ioping](https://github.com/koct9i/ioping) to run these benchmarks.
First step is to connect via terminal to any container within the Container App (skip this if you are already connected):

```az-cli
az containerapp exec --name storage-demo --resource-group rg-academo --container container1
```

And then let's use apt-get to install both packages:

```bash
apt-get update && apt-get install fio -y && apt-get install ioping -y
```

Now, benchmarking I/O is always a polemic topic. There are many different settings for different type of applications:
- Sequential reads/writes
- Random reads/writes
- Block size
- Number of threads
- etc...

For all possible settings, check [fio](https://github.com/axboe/fio) documentation. But of course, the best thing is to always benchmark using a real application in your scenario.
For this demo, we will be simulating random reads of a 1GB file for 10 seconds, using the default block size for each storage type:

Container file system:
```bash
fio --filename=/performance.test --direct=1 --rw=randread --bs=4096B --ioengine=libaio --iodepth=256 --runtime=10 --numjobs=4 --time_based --group_reporting --name=iops-test-job  --eta-newline=1 --size=1Gi
```

Temporary storage:
```bash
fio --filename=/volumes/temp/performance.test --direct=1 --rw=randread --bs=4096B --ioengine=libaio --iodepth=256 --runtime=10 --numjobs=4 --time_based --group_reporting --name=iops-test-job  --eta-newline=1 --size=1Gi
```

Azure files share:
```bash
fio --filename=/volumes/azurefile/performance.test --direct=1 --rw=randread --bs=65536B --ioengine=libaio --iodepth=256 --runtime=10 --numjobs=4 --time_based --group_reporting --name=iops-test-job --eta-newline=1 --size=1Gi
```

For these runs, these are the results from the console:
| Storage type | Throughput |
| -- | -- |
| Container file system | 31 MB/s |
| Temporary storage | 34 MB/s |
| Azure Files Share | 67 MB/s |

There is a big catch in these results. It looks like Azure Files Share is faster than the other options because look at the parameter block size for the run "--bs=65536B". The default block size that gets mounted for a Azure File Share inside the container is 65kb but that might be unrealistic for applications reading many smaller files in parallel, files much smaller than 65kb. Then the disk access latency plays a more important role in these scenarios. Let's now look in the latency results by using [ioping](https://github.com/koct9i/ioping):

Container file system:
```bash
ioping /performance.test
```

Temporary storage:
```bash
ioping /volumes/temp/performance.test
```

Azure files share:
```bash
ioping /volumes/azurefile/performance.test
```

| Storage type | Disk access latency |
| -- | -- |
| Container file system | 0.2ms |
| Temporary storage | 0.2 ms |
| Azure Files Share | 4 ms (some spikes up to 60ms) |

As we can see, the disk access latency to Azure Files Share is much higher and more variable than the others. It is because behind the scenes there is a network call using the CIFS (SMB) protocol. So for workloads that require a lot of smaller and parallel access to files, Azure Files Share might not be a good fit. But for dealing with larger files, which will its full block size of 65kb it should be suitable.

As a final test, lets try to run a benchmark against Azure Files Share using a small 4kb block size:

Azure files share:
```bash
fio --filename=/volumes/azurefile/performance.test --direct=1 --rw=randread --bs=4096B --ioengine=libaio --iodepth=256 --runtime=10 --numjobs=4 --time_based --group_reporting --name=iops-test-job --eta-newline=1 --size=1Gi
```

The average throughput now drops to only **4 MB/s**. It shows how much important it is to benchmark using your real-world applications and not rely purely on benchmarking tools.

## Conclusion
Hopefully, this walkthrough was useful to understand the different types of storage available in Azure Container Apps. 
The expectation is that more options are available to ACA over time and it starts to catch up with the offerings available in [AKS](https://docs.microsoft.com/en-us/azure/aks/concepts-storage). 
For workloads that require very fast permanent storage and requires multiple concurrent small random reads/writes, ACA might not be the ideal choice just yet. Databases are one example of such workload - but remember ACA purpose is that you leverage PaaS services from Azure like Azure SQL and don't host them yourself.
