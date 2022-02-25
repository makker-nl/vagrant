RHCRS_HOME=/app/redhat/codereadystudio
echo start RedHat CodeReadyStudio
nohup ssh redhat@localhost -p 2222 $RHCRS_HOME/codereadystudio > codereadystudio.out 2>&1 & 