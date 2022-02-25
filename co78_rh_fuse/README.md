# CentOS 7 update 8: Red Hat Fuse Development environment
This vagrant projec creates a VM with Red Hat Fuse development environment.

## Users: 
+ root - vagrant
+ vagrant - vagrant
+ redhat - welcome1

## VM Settings:
The main VM settings are abstracted into the [settings.yml](settings.yml) file. 

| Property               | Default       | Description                                     |
| ---------------------- | ------------- |  ---------------------------------------------- |
| environment.vmMemory   | 12288         | Allocated memory for the VM. At least 8GB is recommended. Depending on the available host memory. |
| environment.vmCpus     | 4             | Number of CPU's allocated to the VM. Don't exceed the available cores of the host. | 
| environment.vmGui      | false         | Toggle to denote if the Desktop is to be shown (true) or should run in head-less mode (false) |
| environment.vmsHome               | C:/Data/VirtualMachines/VirtualBox | Location where VirtualBox will store the VM's. Change the VirtualBox preference to this value. Or vice versa. |
| environment.disks.vmsDisk2Size    | 524288        | Size of the additional disk that will be created (1024 * 512 = 524288).|
| sharedFolders.stageHostFolder     | c:/Data/git/makker/vagrant/Stage| Location of the Stage folder within the Vagrant project. Here the install scripts and install binaries are expected. |
| sharedFolders.stageGuestFolder    | /media/sf_Stage | Local file mount refering to the STAGE_HOST_FOLDER. Don't change it |
| sharedFolders.projectHostFolder   | c:/Data/git/VS/redhat-fuse/application-development | Location of the Projects folder, to use to store project files. For example to get to folder with local Git clones. |
| sharedFolders.projectGuestFolder  | /media/sf_Projects | Local file mount refering to the STAGE_HOST_FOLDER. Don't change it |

The settings expect that you checked out the vagrant project in _c:/Data/git/makker_. If you checked out the Vagrant GitHub project in a different environment then prescribed, you would need to change the _sharedFolders.stageHostFolder_ property accordingly.
The _sharedFolders.projectHostFolder_ points to the folder where I keep my company projects. You might want to change that accordingly as well. I assume you don't have that folder.


## Installations:
Which provisioners are executed can be set in the  [provisioners.yml](provisioners.yml) file. 
Several of the available provisioners are:
+ **OpenJDK 11** in /etc/alternatives/java_sdk -> /usr/lib/jvm/java-11-openjdk-11.0.8.10-0.el7_8.x86_64
+ **Git** [Check out post-provisioning configuration](../Stage/commonScripts/opensource/git/README.md).
+ **OracleJDK 8** in /app/oracle/product/jdk8 [Download Installer](../Stage/installBinaries/Oracle/Java).
+ **OracleJDK 11** in /app/oracle/product/jdk11 [Download Installer](../Stage/installBinaries/Oracle/Java).
+ **Code Ready Studio v. 12.21** in /app/redhat/codereadystudio. [Download Installer](../Stage/installBinaries/RedHat).
+ **Apache Maven 3.8.3** Maven home: /opt/maven
+ **Apache Active MQ Artemis 5.5.0** in /app/opensource/apache-artemis-2.15.0 and broker in /app/work/artemis/amqbroker. [Download Installer](../Stage/installBinaries/OpenSource/AMQ_Artemis).
+ **SoapUI 5.7.0** in /app/opensource/SoapUI-5.7.0. [Download Installer](../Stage/installBinaries/OpenSource/SoapUI).
+ **Docker** Including move of the Docker local storage folder to /app/docker/data
+ **Docker Compose (docker-compose)** 
+ **Postman Latest** from https://dl.pstmn.io/download/latest/linux64
+ **Red Hat OpenShift CLI (oc) version** [Download Installer](../Stage/installBinaries/RedHat).

This list is not complete, as provisioners can be added from time to time.

## Provisioners:
The following provisioners are created.

| Name                   | run           | Description                     |
| ---------------------- | ------------- |---------------------------------|
| init                   | once          | Initialize VM                   |
| installJava11          | once          | Install OpenJDK 11              |
| installOJava8          | once          | Install Oracle JDK 8            |
| installMaven           | once          | Install Apache Maven            |
| installCodeReadyStudio | once          | Install RedHat CodeReady Studio |
| installAMQ             | once          | Install Active MQ               |
| startAMQBroker         | always        | Start Active MQ Broker          |
| stopAMQBroker          | never         | Stop Active MQ Broker           |
| installSoapUI          | once          | Install SoapUI                  |
| installDocker          | once          | Install Docker                  |
| installDockerCompose   | once          | Install docker-compose          |
| installPostman         | once          | Install Postman (Latest)        |
| installOc              | never         | Install Red Hat OpenShift CLI   |
| installKubectl         | never         | Kubernetes Control CLI          |
| installHelm            | never         | Helm commandline interface      |
| installTektonCLI       | never         | Tekton CLI                      |
| installYq              | never         | yq yaml query                   |

The [provisioners.yml](provisioners.yml) file allows for toggling the run property, to be able to pick&choose which provisioners should be run. Additional Provisioners can be added when needed, and using this file enabled or disabled. The some provisioners the user for which the provisioner will be run can be changed. In most cases this is the _redhat_ user and should not be changed.

To execute a specific provisioner, even after a VM is already provisioned execute:
```
vagrant provision --provision-with _provisioner-name_
```
For example, to stop the AMQ broker:
```
vagrant provision --provision-with stopAMQBroker
```

# Hyper-V en Credential/Hypervisor security
On some Laptops with Windows Professional the Windows Hyper Visor and/or Credential Security en/of HyperVisor Security are enabled. This obstructs the creation and startup of the VM. A workaround for this problem is as follows:

+    Switch of Hyper-V completely (through Windows Features);
    Navigate to: https://www.microsoft.com/en-us/download/details.aspx?id=53337 and download the tool (powershell script);

+    Using PowerShell navigate to the downloaded script (CD <locatie>), followd by:
    set-executionpolicy bypass -scope currentuser -force ;

+    Lastly, execute the following:
    .\DG_Readiness_Tool_v3.6.ps1 -disable

+    This results in an allert to restart. To do this quickly, execute:
    > shutdown /r /t 0
    As soon as the laptop starts, the BIOS will ask you one or twice to confirm. Answer with F3 and enter (aka. the any-key.). You may also hit the F3 key several times, to speed through this process.

You may repeat this after a restart or after a Windows update