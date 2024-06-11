# Oracle Linux 8: Oracle Development environment
This vagrant project creates a VM with a development environment.

## Upgrade remarks
* projects: backup/copy your git folder
* scripts/binaries: backup/copy the redhat/bin folder
* Maven: backup/copy the redhat/bin .m2 folder. use the mvn-switch.sh script to recreate the symbolic link to the settings.xml. Make sure that the global and user settings in Eclipse/CodeReadyStudio are set correctly.
* SSH: backup/copy the  .ssh folder. Don't share your keys! Make sure that in the new VM the fileattrubutes of the .ssh contents are 0600 (chmod 0600 *)


## Users: 
+ root - vagrant
+ vagrant - vagrant
+ oracle - welcome1

## VM Settings:
The main VM settings are abstracted into the [settings.yml](settings.yml) file. 

| Property               | Default       | Description                                     |
| ---------------------- | ------------- |  ---------------------------------------------- |
| environment.vmMemory   | 11264         | Allocated memory for the VM. At least 8GB is recommended. Depending on the available host memory. |
| environment.vmCpus     | 4             | Number of CPU's allocated to the VM. Don't exceed the available cores of the host. | 
| environment.vmGui      | false         | Toggle to denote if the Desktop is to be shown (true) or should run in head-less mode (false) |
| environment.vmsHome               | C:/Data/VirtualMachines/VirtualBox | Location where VirtualBox will store the VM's. Make sure it reflects the setting in VirtualBox Preferences -> _General_ -> *Default Machine Folder*. Or vice versa. |
| environment.disks.vmsDisk2Size    | 524288        | Size of the additional disk that will be created (1024 * 512 = 524288).|
| sharedFolders.stage.host     | c:/Data/git/makker/vagrant/Stage | Location of the Stage folder within the Vagrant project. Here the install scripts and install binaries are expected. It's based on the folder of the vagrant project eg. _c:/Data/git/makker_. Change it accordingly. |
| sharedFolders.stage.guest    | /media/sf_Stage | Local file mount refering to the STAGE_HOST_FOLDER. Don't change it |
| sharedFolders.project.host   | c:/Data/projects | Location of the Projects folder, to use to store project files. For example to get to folder with local Git clones. |
| sharedFolders.project.guest  | /media/sf_Projects | Local file mount refering to the STAGE_HOST_FOLDER. Don't change it |

Check the following setting for your environment:
* environment.vmsHome
* sharedFolders.stage.host
* sharedFolders.project.host

The sharedFolder _stage_ is mandatory, since the provisioners rely on it. The shared folder _project_ is an example. You can modify, replace, or even delete it.
You can add as many shared folders as you like. To add a shared folder, add an extra node under sharedFolders, with a host and a guest attribute. Like:
````
sharedFolders:
  stage:
    host: c:/Data/git/makker/vagrant/Stage
    guest: /media/sf_Stage
  ....
  mySharedFolder:
    host: c:/Data/mySharedFolder
    guest: /media/sf_MySharedFolder
````


## Provisioners:
The following provisioners are created.

| Name                   | run           | Description                     | Links    |
| ---------------------- | ------------- |---------------------------------| -------- |
| prepLinux              | once          | Prepare linux                   |          |
| initFileSystem         | once          | Initialize Filesystem on disk 2 |          |
| addOracleUser          | once          | Install Git                     | [Post-provisioning configuration](../Stage/commonScripts/opensource/git/README.md) |
| installJava11          | once          | Install OpenJDK 11              |          |
| installGit             | once          | Install OpenJDK 11              |          |
| installOJava8          | once          | Install Oracle JDK 8            | [Install Readme](../Stage/commonScripts/oracle/java/README.md), [Download Installer](../Stage/installBinaries/Oracle/Java/README.md) |
| installOJava11         | once          | Install Oracle JDK 11           | [Install Readme](../Stage/commonScripts/oracle/java/README.md), [Download Installer](../Stage/installBinaries/Oracle/Java/README.md) |
| installPython3         | once          | Install Python 3                |          |
| installMaven           | once          | Install Apache Maven            |          |
| installEclipse         | once          | Install Eclipse                 | [Install Readme](../Stage/commonScripts/opensource/eclipse/README.md), [Download Installer](../Stage/installBinaries/OpenSource/Eclipse/README.md) |
| installDocker          | never         | Install Docker                  |          |
| installDockerCompose   | never         | Install docker-compose          |          |
| installSoapUI          | once          | Install SoapUI                  | [Install Readme](../Stage/commonScripts/opensource/SoapUI/README.md), [Download Installer](../Stage/installBinaries/OpenSource/SoapUI/README.md) |
| installPostman         | once          | Install Postman (Latest)        |          |
| installSoaQS           | never         | Install Oracle SOA QuickStart   | _to be described_ |
| installKubectl         | never         | Install Kubernetes Control CLI  |          |
| installHelm            | never         | Install Helm commandline interface |          |
| installOCICLI          | never         | Install Oracle OCI CLI          |          |  
| installAzCLI           | never         | Install Azure CLI               |          |
| installTektonCLI       | never         | Install Tekton CLI              |          |
| installRegctl          | never         | Install Registry Client         | [Install Regclient](https://github.com/regclient/regclient/blob/main/docs/install.md) |
| installYq              | never         | Install yq yaml query           |          |
| installNetbeans        | never         | Install Apache Netbeans         | [Install Readme](../Stage/commonScripts/opensource/netbeans/README.md) | 
| installSQLDeveloper    | never         | Install Oracle SQL Developer    | [Install Readme](../Stage/commonScripts/oracle/db/sqldev/README.md), [Download Installer](../Stage/installBinaries/Oracle/DB/SQLDeveloper/README.md) |
| installNodeJS          | never         | Install Node.js                 |          |
| installVSCode          | never         | Install Visual Studio Code      |          |
| installLensDesktop     | never         | Install Lens desktop            |          |
| installPodman          | never         | Install Podman                  | [Install Podman](https://podman.io/docs/installation), [Get started with Podman](https://docs.oracle.com/en/learn/intro_podman/index.html#introduction), [Relocate image data](https://docs.oracle.com/en/operating-systems/oracle-linux/podman/podman-ConfiguringStorageforPodman.html#podman-install-storage)      |
| installSkopeo          | never         | Install Skopeo                  | [Install](https://github.com/containers/skopeo/blob/main/install.md#rhel--centos-stream--8) |

"
  description: ""
  user: "oracle"
  run: "never"
  commonScript: "/opensource/lens/ol_installLens.sh"
podman:
  name: ""
  description: ""
  user: "oracle"
  run: "never"
  commonScript:  "/opensource/podman/installPodman.sh"
skopeo:
  name: ""
  description: "Install "
  user: "oracle"
  run: "never"


The [provisioners.yml](provisioners.yml) file allows for toggling the run property, to be able to pick&choose which provisioners should be run. Additional Provisioners can be added when needed, and using this file enabled or disabled. The some provisioners the user for which the provisioner will be run can be changed. In most cases this is the _oracle_ user and should not be changed.

To execute a specific provisioner, even after a VM is already provisioned execute:
```
vagrant provision --provision-with _provisioner-name_
```

# Notes
Some of the scripts are based on CentOS setups and have _co_ in the name. They might need to be replaced by an Oracle Linux variant.
Especially the installDocker scripts, since they refer to a CentOS Repository.