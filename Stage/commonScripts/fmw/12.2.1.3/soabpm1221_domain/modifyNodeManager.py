#############################################################################
# Create a SOA/BPM/OSB/WC domain
#
# @author Martien van den Akker, Darwin-IT Professionals
# @version 1.0, 2016-04-06
#
#############################################################################
# Modify these values as necessary
import sys, traceback
from datetime import datetime
scriptName = sys.argv[0]
#
#Home Folders
fmwHome = os.getenv('FMW_HOME')
javaHome = os.getenv('JAVA_HOME')
wlsHome    = fmwHome+'/wlserver'
domainHome       = domainsHome+'/'+domainName
applicationsHome = applicationsBaseHome+'/'+domainName
#
#
lineSeperator='__________________________________________________________________________________'
#
#
def usage():
  print 'Call script as: '
  print 'Windows: wlst.cmd '+scriptName+' -loadProperties localhost.properties'
  print 'Linux: wlst.sh '+scriptName+' -loadProperties environment.properties'
  print 'Property file should contain the following properties: '
  print "adminUrl=localhost:7101"
  print "adminUser=weblogic"
  print "adminPwd=welcome1"
#
# Create a NodeManager properties file.
def createNodeManagerPropertiesFile(javaHome, nodeMgrHome, nodeMgrType, nodeMgrListenAddress, nodeMgrListenPort):
  print ('Create Nodemanager Properties File for home: '+nodeMgrHome)
  print (lineSeperator)
  nmProps=nodeMgrHome+'/nodemanager.properties'
  fileNew=open(nmProps, 'w')
  fileNew.write('#Node manager properties\n')
  fileNew.write('#%s\n' % str(datetime.now()))
  fileNew.write('DomainsFile=%s/%s\n' % (nodeMgrHome,'nodemanager.domains'))
  fileNew.write('LogLimit=0\n')
  fileNew.write('PropertiesVersion=12.2.1\n')
  fileNew.write('AuthenticationEnabled=true\n')
  fileNew.write('NodeManagerHome=%s\n' % nodeMgrHome)
  fileNew.write('JavaHome=%s\n' % javaHome)
  fileNew.write('LogLevel=INFO\n')
  fileNew.write('DomainsFileEnabled=true\n')
  fileNew.write('ListenAddress=%s\n' % nodeMgrListenAddress)
  fileNew.write('NativeVersionEnabled=true\n')
  fileNew.write('ListenPort=%s\n' % nodeMgrListenPort)
  fileNew.write('LogToStderr=true\n')
  fileNew.write('weblogic.StartScriptName=startWebLogic.sh\n')
  if nodeMgrType == 'ssl':
    fileNew.write('SecureListener=true\n')
  else:
    fileNew.write('SecureListener=false\n')
  fileNew.write('LogCount=1\n')
  fileNew.write('QuitEnabled=true\n')
  fileNew.write('LogAppend=true\n')
  fileNew.write('weblogic.StopScriptEnabled=true\n')
  fileNew.write('StateCheckInterval=500\n')
  fileNew.write('CrashRecoveryEnabled=false\n')
  fileNew.write('weblogic.StartScriptEnabled=true\n')
  fileNew.write('LogFile=%s/%s\n' % (nodeMgrHome,'nodemanager.log'))
  fileNew.write('LogFormatter=weblogic.nodemanager.server.LogFormatter\n')
  fileNew.write('ListenBacklog=50\n')
  fileNew.flush()
  fileNew.close()
#
# Create a NodeManager Service Script file.
def createNmServiceScript(nmServiceScriptName, javaHome, fmwHome, domainHome, nodeMgrHome):
  print ('Create Nodemanager Service ScriptFile File '+nmServiceScriptName+'for home: '+domainHome)
  print (lineSeperator)
  fileNew=open(nodeMgrHome+'/'+nmServiceScriptName, 'w')
  fileNew.write('#!/bin/sh\n')
  fileNew.write('#\n')
  fileNew.write('# chkconfig:   345 85 15\n')
  fileNew.write('# description: per domain Oracle Weblogic Node Manager service init script\n\n')
  #
  fileNew.write('### BEGIN INIT INFO\n')
  fileNew.write('# Provides: nodemanager\n')
  fileNew.write('# Required-Start: $network $local_fs\n')
  fileNew.write('# Required-Stop:\n')
  fileNew.write('# Should-Start:\n')
  fileNew.write('# Should-Stop:\n')
  fileNew.write('# Default-Start: 3 4 5\n')
  fileNew.write('# Default-Stop: 0 1 2 6\n')
  fileNew.write('# Short-Description: per domain Oracle Weblogic Node Manager service.\n')
  fileNew.write('# Description: Starts and stops per domain Oracle Weblogic Node Manager.\n')
  fileNew.write('### END INIT INFO\n\n')
  #
  fileNew.write('. /etc/rc.d/init.d/functions\n\n')
  #
  fileNew.write('#### BEGIN CUSTOM ENV\n')
  fileNew.write('DOMAIN_HOME=\"%s\"\n' % domainHome)
  fileNew.write('PROCESS_OWNER=oracle\n')
  fileNew.write('MW_HOME=%s\n' % fmwHome)
  fileNew.write('JAVA_HOME=%s\n' % javaHome)
  fileNew.write('LD_LIBRARY_PATH=$MW_HOME/wlserver/server/native/linux/x86_64:/usr/lib:/lib\n')
  fileNew.write('#### END CUSTOM ENV\n\n')
  #
  fileNew.write('PROCESS_STRING="^.*$DOMAIN_HOME.*weblogic.NodeManager.*"\n')
  fileNew.write('PROGRAM_START="$DOMAIN_HOME/bin/startNodeManager.sh"\n')
  fileNew.write('NODEMANAGER_DIR=%s\n' % nodeMgrHome)
  fileNew.write('NODEMANAGER_LOCKFILE="$NODEMANAGER_DIR/nodemanager.log.lck"\n')
  fileNew.write('OUT_FILE="$NODEMANAGER_DIR/nodemanager.out"\n\n')
  # 
  fileNew.write('SERVICE_NAME=`/bin/basename $0`\n')
  fileNew.write('LOCKFILE="/var/lock/subsys/$SERVICE_NAME"\n\n')
  fileNew.write('RETVAL=0\n\n')
  #
  fileNew.write('start() {\n')
  fileNew.write('        OLDPID=`/usr/bin/pgrep -f $PROCESS_STRING`\n')
  fileNew.write('        if [ ! -z "$OLDPID" ]; then\n')
  fileNew.write('            echo "$SERVICE_NAME is already running (pid $OLDPID) !"\n')
  fileNew.write('            echo\n')
  fileNew.write('            exit\n')
  fileNew.write('        fi\n')
  fileNew.write('        echo -n $"Starting $SERVICE_NAME ... "\n')
  fileNew.write('        echo "`date` Starting $SERVICE_NAME ... " > $OUT_FILE 2>&1 \n')
  fileNew.write('        export MW_HOME\n')
  fileNew.write('        export JAVA_HOME\n')
  fileNew.write('export LD_LIBRARY_PATH\n')
  fileNew.write('su - $PROCESS_OWNER -c  $PROGRAM_START >> $OUT_FILE 2>&1  &\n')
  fileNew.write('        RETVAL=$?\n')
  fileNew.write('        if [ $RETVAL -eq 0 ] ; then\n')
  fileNew.write('          wait_for "socket listener started on port"\n')
  fileNew.write('        else\n')
  fileNew.write('          echo "FAILED: $RETVAL. Please check $OUT_FILE for more information."\n')
  fileNew.write('        fi\n')
  fileNew.write('        echo\n')
  fileNew.write('}\n\n')
  #
  fileNew.write('wait_for() {\n')
  fileNew.write('    res=$(cat "$OUT_FILE" | fgrep -c "$1")\n')
  fileNew.write('    count=60\n')
  fileNew.write('    while [[ ! $res -gt 0 ]] && [[ $count -gt 0 ]]\n')
  fileNew.write('    do\n')
  fileNew.write('        sleep 1\n')
  fileNew.write('        count=$(($count - 1))\n')
  fileNew.write('        res=$(cat "$OUT_FILE" | fgrep -c "$1")\n')
  fileNew.write('    done\n')
  fileNew.write('    res=$(cat "$OUT_FILE" | fgrep -c "$1")\n')
  fileNew.write('    if [ ! $res -gt 0 ]; then\n')
  fileNew.write('        echo "FAILED or took too long time to start. Please check $OUT_FILE for more information."\n')
  fileNew.write('    else\n')
  fileNew.write('        echo "OK"\n')
  fileNew.write('        touch $LOCKFILE\n')
  fileNew.write('    fi\n')
  fileNew.write('}\n\n')
  #
  fileNew.write('stop() {\n')
  fileNew.write('        echo -n $"Stopping $SERVICE_NAME ... "\n')
  fileNew.write('        OLDPID=`/usr/bin/pgrep -f $PROCESS_STRING`\n')
  fileNew.write('        if [ "$OLDPID" != "" ]; then\n')
  fileNew.write('            echo -n "(pid $OLDPID) "\n')
  fileNew.write('            /bin/kill -TERM $OLDPID\n\n')
  #
  fileNew.write('            RETVAL=$?\n')
  fileNew.write('            echo "OK"\n')
  fileNew.write('            /bin/rm -f $NODEMANAGER_LOCKFILE\n')
  fileNew.write('            [ $RETVAL -eq 0 ] && rm -f $LOCKFILE\n')
  fileNew.write('        else\n')
  fileNew.write('            /bin/echo "$SERVICE_NAME is stopped"\n')
  fileNew.write('        fi\n')
  fileNew.write('        echo\n')
  fileNew.write('}\n\n')
  #
  fileNew.write('restart() {\n')
  fileNew.write('        stop\n')
  fileNew.write('        sleep 10\n')
  fileNew.write('        start\n')
  fileNew.write('}\n\n')
  #
  fileNew.write('case "$1" in\n')
  fileNew.write('  start)\n')
  fileNew.write('        start\n')
  fileNew.write('        ;;\n')
  fileNew.write('  stop)\n')
  fileNew.write('        stop\n')
  fileNew.write('        ;;\n')
  fileNew.write('  restart|force-reload|reload)\n')
  fileNew.write('        restart\n')
  fileNew.write('        ;;\n')
  fileNew.write('  condrestart|try-restart)\n')
  fileNew.write('        [ -f $LOCKFILE ] && restart\n')
  fileNew.write('        ;;\n')
  fileNew.write('  status)\n')
  fileNew.write('        OLDPID=`/usr/bin/pgrep -f $PROCESS_STRING`\n')
  fileNew.write('        if [ "$OLDPID" != "" ]; then\n')
  fileNew.write('            /bin/echo "$SERVICE_NAME is running (pid: $OLDPID)"\n')
  fileNew.write('        else\n')
  fileNew.write('            /bin/echo "$SERVICE_NAME is stopped"\n')
  fileNew.write('        fi\n')
  fileNew.write('        echo\n')
  fileNew.write('        RETVAL=$?\n')
  fileNew.write('        ;;\n')
  fileNew.write('  *)\n')
  fileNew.write('        echo $"Usage: $0 {start|stop|status|restart|reload|force-reload|condrestart}"\n')
  fileNew.write('        exit 1\n')
  fileNew.write('esac\n')
  #
  fileNew.write('exit $RETVAL\n')
  #
  fileNew.flush()
  fileNew.close()  
#
# Backup NM Properties
def backupNMProps(nodeMgrHome):
  nmProps=nodeMgrHome+'/nodemanager.properties'
  nmPropsBck=nodeMgrHome+'/nodemanager.properties.org'
  print ('Rename File '+nmProps+' to '+nmPropsBck)  
  print (lineSeperator)
  os.rename(nmProps, nmPropsBck)  
#
#
def main():
  try:
    #
    # Section 1 Modify Nodemanager 1
    print (lineSeperator)
    print ('1. Modify Nodemanager 1 for NodeManager Home '+nodeMgr1Home)
    print ('1.1. Backup Nodemanager Properties')
    print (lineSeperator)    
    backupNMProps(nodeMgr1Home)
    print ('\n1.2. Create New Nodemanager Properties')
    print (lineSeperator)    
    createNodeManagerPropertiesFile(javaHome, nodeMgr1Home, nodeMgr1Type, server1Address, nodeMgr1ListenPort)
    print ('\n1.3. Create Nodemanager Service Script')
    print (lineSeperator)    
    createNmServiceScript(nodeMgr1SvcName, javaHome, fmwHome, domainHome, nodeMgr1Home)
    #
    # Section 2 Modify Nodemanager 2
    if server2Enabled == 'true':
      print ('2. Modify Nodemanager 2 for NodeManager Home '+nodeMgr2Home)
      print ('2.1. Backup Nodemanager Properties')
      print (lineSeperator)
      backupNMProps(nodeMgr1Home)
      print ('\n2.2. Create New Nodemanager Properties')
      print (lineSeperator)
      createNodeManagerPropertiesFile(javaHome, nodeMgr2Home, nodeMgr2Type, server2Address, nodeMgr2ListenPort)
      print ('\n2.3. Create Nodemanager Service Script')
      print (lineSeperator)
      createNmServiceScript(nodeMgr2SvcName, javaHome, fmwHome, domainHome, nodeMgr2Home)
    else:
      print ('2. Skip Nodemanager 2 as server2Enabled=false')    
    #
    print ('\nFinished')
    #
    print('\nExiting...')
    exit()
  except NameError, e:
    print 'Apparently properties not set.'
    print "Please check the property: ", sys.exc_info()[0], sys.exc_info()[1]
    usage()
  except:
    apply(traceback.print_exception, sys.exc_info())
    stopEdit('y')
    exit(exitcode=1)
#call main()
main()
exit()
