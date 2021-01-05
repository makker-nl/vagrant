minishift ssh
sudo useradd redhat
passwd redhat
echo password: redhatfuse77 (BAD Password)
sudo sh -c "echo '%redhat ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers.d/redhat"
sudo cat /etc/sudoers.d/redhat