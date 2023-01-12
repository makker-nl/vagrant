[infra]
infraserver1 ansible_ssh_host=$HOST_IP ansible_ssh_port=22 ansible_ssh_user=oracle ansible_ssh_private_key_file=/home/oracle/.ssh/id_rsa

[database]
dbserver1 ansible_ssh_host=$HOST_IP ansible_ssh_port=22 ansible_ssh_user=oracle ansible_ssh_private_key_file=/home/oracle/.ssh/id_rsa