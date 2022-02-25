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
| sharedFolders.stageHostFolder     | c:/Data/git/VS/redhat-fuse/application-development/vagrant/Stage| Location of the Stage folder within the Vagrant project. Here the install scripts and install binaries are expected. |
| sharedFolders.stageGuestFolder    | /media/sf_Stage | Local file mount refering to the STAGE_HOST_FOLDER. Don't change it |
| sharedFolders.projectHostFolder   | c:/Data/git/VS/redhat-fuse/application-development | Location of the Projects folder, to use to store project files. For example to get to folder with local Git clones. |
| sharedFolders.projectGuestFolder  | /media/sf_Projects | Local file mount refering to the STAGE_HOST_FOLDER. Don't change it |

If you checked out the Vagrant GitLab in a different environment then prescribed, you would need to change the _STAGE_HOST_FOLDER_ variable accordingly.

## Installations:
+ **OpenJDK 11** in /etc/alternatives/java_sdk -> /usr/lib/jvm/java-11-openjdk-11.0.8.10-0.el7_8.x86_64
+ **Git** [Check out post-provisioning configuration](../Stage/commonScripts/opensource/git/README.md).
+ **OracleJDK 8** in /app/oracle/product/jdk8 [Download Installer](../Stage/installBinaries/Oracle/Java).
+ **Code Ready Studio v. 12.18** in /app/redhat/codereadystudio. [Download Installer](../Stage/installBinaries/RedHat).
+ **Apache Maven 3.6.3** Maven home: /opt/maven
+ **Apache Active MQ Artemis 5.5.0** in /app/opensource/apache-artemis-2.15.0 and broker in /app/work/artemis/amqbroker. [Download Installer](../Stage/installBinaries/OpenSource/AMQ_Artemis).
+ **SoapUI 5.5.0** in /app/opensource/SoapUI-5.5.0. [Download Installer](../Stage/installBinaries/OpenSource/SoapUI).
+ **Docker version 19.0.3.13** Including move of the Docker local storage folder to /app/docker/data
+ **Docker Compose (docker-compose) version 1.27.4** from https://github.com/docker/compose/releases/download/1.24.1/docker-compose-Linux-x86_64
+ **Postman Latest** from https://dl.pstmn.io/download/latest/linux64
+ **Red Hat OpenShift CLI (oc) version 3.11.268** [Download Installer](../Stage/installBinaries/RedHat).

**Remark: SoapUI 5.5.0 Requires OracleJDK8. This installation does not include a JRE.**

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

Op sommige VS Laptops staat de Windows Hyper Visor en/of de Credential Security en/of HyperVisor Security aan. Dit belemmert een succesfolle creatie en startup van de VM. Een workaround hiervoor is door ServiceDesk aangereikt. Voer het volgende uit:

+    Schakel Hyper-V volledig uit (bij Windows Features);
    Ga naar: https://www.microsoft.com/en-us/download/details.aspx?id=53337 en download de tool (powershell script);

+    Ga met PowerShell naar de locatie van het gedownloade script (CD <locatie>), gevolgd door:
    set-executionpolicy bypass -scope currentuser -force ;

+    Voer tenslotte het volgende in:
    .\DG_Readiness_Tool_v3.6.ps1 -disable

+    Vervolgens krijg je de melding om opnieuw op te starten. Dat kan snel met:
    > shutdown /r /t 0
    Zodra je dit doet zal de BIOS je een of twee keer om een bevestiging vragen. Beantwoord met F3 en met enter (aka. the any-key.).

Dit moet meestal na een herstart opnieuw gedaan worden. Mocht je tijd hebben om je laptop opnieuw in te richten dan kun je bij de ServiceDesk je laptop opnieuw laten inspoelen met een image waarin dit niet gebeurt.