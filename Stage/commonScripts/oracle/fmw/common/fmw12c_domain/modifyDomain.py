#############################################################################
# Test Datasources on a domain
#
# @author Martien van den Akker, Darwin-IT Professionals
# @version 2.1, 2016-10-04
#
#############################################################################
# Modify these values as necessary
import sys, traceback
scriptName = sys.argv[0]
#
#
lineSeperator='__________________________________________________________________________________'
#
#
def usage():
  print 'Call script as: '
  print 'Windows: wlst.cmd '+scriptName+' -loadProperties localhost.properties'
  print 'Linux: wlst.sh '+scriptName+' -loadProperties environment.properties'
#
def pad(text, num):
  textPad=text+pad
  textPad=textPad[:num]
  return textPad
#
def modifyServer(serverName, listenAddress, svrEnabled):
  if svrEnabled=='true':
    cd('/Servers/'+serverName)
    listenPort=cmo.getListenPort()
    curListenAddress=cmo.getListenAddress()
    print (serverName.ljust(30)+curListenAddress.ljust(30)+str(listenPort).ljust(5)+listenAddress.ljust(30)+svrEnabled.ljust(10))
    cmo.setListenAddress(listenAddress)
    #set('ListenAddress',listenAddress)
    listenPort=cmo.getListenPort()
  else:
    print (serverName.ljust(30)+' '.ljust(30)+' '.ljust(5)+' '.ljust(30)+svrEnabled.ljust(10))
#
def modifyServers():
  print(lineSeperator)
  print 'Modify Weblogic Servers'
  print('Server Name'.ljust(30)+'Current Listen Address'.ljust(30)+'Port'.ljust(5)+'New Listen Address'.ljust(30)+'Enabled'.ljust(10))
  modifyServer(adminServerName, adminListenAddress, 'true')
  modifyServer(soaSvr1, server1Address, soaEnabled)
  modifyServer(soaSvr2, server2Address, soaSvr2Enabled)
  modifyServer(osbSvr1, server1Address, osbEnabled)
  modifyServer(osbSvr2, server2Address, osbSvr2Enabled)
#
def modifyMachine(serverMachine,listenAddress,listenPort, nmType,nmEnabled):
  if nmEnabled == 'true':
    cd('/UnixMachine/'+serverMachine+'/NodeManager/'+serverMachine)
    curListenAddress = cmo.getListenAddress()
    curListenPort = cmo.getListenPort()
    curNmType = cmo.getNMType()
    #set('ListenAddress',listenAddress)
    #set('ListenPort',listenPort)
    #set('NMType',nmType)
    print (serverMachine.ljust(30)+curListenAddress.ljust(30)+str(curListenPort).ljust(7)+curNmType.ljust(10)+listenAddress.ljust(30))
    cmo.setListenAddress(listenAddress)
  else:
    print (serverMachine.ljust(30)+' '.ljust(30)+' '.ljust(7)+' '.ljust(10)+listenAddress.ljust(30))
#

def modifyMachines():
  print(lineSeperator)
  print('Modify Machines')
  print ('Machine Name'.ljust(30)+'Current ListenAddress '.ljust(30)+'Port'.ljust(7)+'Type'.ljust(10)+'New Listen Address'.ljust(30))
  modifyMachine(server1Machine,nodeMgr1ListenAddress,nodeMgr1ListenPort,nodeMgr1Type,'true')
  modifyMachine(server2Machine,nodeMgr2ListenAddress,nodeMgr2ListenPort,nodeMgr2Type,server2Enabled)

#
def modifyDataSources():
  print(lineSeperator)
  print('Modify Datasources')
  # Assumption: database runs on same host as weblogic and thus nodemanager host is db host.
  newDbUrl=soaRepositoryDbUrl
  dataSourceHeadPad = 'DataSource'.ljust(30)
  curDbUrlHeadPad='Current DB URL'.ljust(60)
  newDbUrlHeadPad='New DB URL'.ljust(60)
  print(dataSourceHeadPad + curDbUrlHeadPad+newDbUrlHeadPad)
  allJDBCSysResources=cmo.getJDBCSystemResources()
  if (len(allJDBCSysResources) > 0):
    for jdbcSysResource in allJDBCSysResources:
      jdbcSysResourceName = jdbcSysResource.getName()
      jdbcResourcePath = '/JDBCSystemResource/'+jdbcSysResourceName+'/JdbcResource/'+jdbcSysResourceName
      jdbcDriverParmsPath = jdbcResourcePath+'/JDBCDriverParams/NO_NAME_0'
      cd(jdbcDriverParmsPath)
      dbUrl = cmo.getUrl()
      print(jdbcSysResourceName.ljust(30)+dbUrl.ljust(60)+newDbUrl.ljust(60))
      cmo.setUrl(newDbUrl)
#
#
def main():
  try:
    domainHome = domainsHome+'/'+domainName
    print(lineSeperator)
    print('Modify domain after cloning VM.')
    print(lineSeperator)
    print('Read domain '+domainHome)
    readDomain(domainHome)
    modifyDataSources()
    print(lineSeperator)
    modifyServers()
    print(lineSeperator)
    modifyMachines()
    print(lineSeperator)
    print('Update domain '+domainHome)
    updateDomain()
    print('Closing the domain.')
    closeDomain();
    print('Done...')
    print(lineSeperator)
  except NameError, e:
    print('Apparently properties not set.')
    print "Please check the property: ", sys.exc_info()[0], sys.exc_info()[1]
    usage()
  except:
    apply(traceback.print_exception, sys.exc_info())
    exit(exitcode=1)
#
main();
