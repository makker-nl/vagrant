#############################################################################
# Start, Stop, Restart FMW Domain
#
# @author Martien van den Akker, Darwin-IT Professionals
# @version 1.1, 2017-04-20
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
  print 'Property file should contain the following properties: '
  print "adminUrl=localhost:7001"
  print "adminUser=weblogic"
  print "adminPwd=welcome1"
# 
#
def connectToNM():
  try:
    wlsDomainHome = wlsDomainsHome+'/'+wlsDomainName
    print(lineSeperator)
    print('Try to connect to the Node Manager')
    try:
      nmConnect(userConfigFile=usrCfgFile, userKeyFile=usrKeyFile, host=nmHost, port=nmPort, domainName=wlsDomainName, domainDir=wlsDomainHome, nmType=nmType)
    except NameError, e:
      print('Apparently user config properties usrCfgFile and usrKeyFile not set.')
      print('Try to connect to the NodeManager adminUser and adminPwd properties')
      nmConnect(username=adminUser, password=adminPwd, host=nmHost, port=nmPort, domainName=wlsDomainName, domainDir=wlsDomainHome, nmType=nmType)
    print('Connected to the Node Mananger')
  except WLSTException:
    message='Apparently NodeManager not Started!'
    print (message)
    raise Exception(message)
#
# Start Admin Server
def startAdminServer(adminServerName):
  # Set wlsDomainHome
  print ('Connect to the Node Manager')
  connectToNM()
  print('Start AdminServer')
  nmStart(adminServerName)
#
# Connect To the AdminServer
def connectToAdminServer(adminUrl, adminServerName):
  try:
    print(lineSeperator)
    print('Try to connect to the AdminServer')
    try:
      connect(userConfigFile=usrCfgFile, userKeyFile=usrKeyFile, url=adminUrl)
    except NameError, e:
      print('Apparently user config properties usrCfgFile and usrKeyFile not set.')
      print('Try to connect to the AdminServer adminUser and adminPwd properties')
      connect(adminUser, adminPwd, adminUrl)
  except WLSTException:
    print('Apparently AdminServer not Started!')
    startAdminServer(adminServerName)
    print('Retry to connect to the AdminServer')
    try:
      connect(userConfigFile=usrCfgFile, userKeyFile=usrKeyFile, url=adminUrl)
    except NameError, e:
      print('Apparently user config properties usrCfgFile and usrKeyFile not set.')
      print('Try to connect to the AdminServer adminUser and adminPwd properties')
      connect(adminUser, adminPwd, adminUrl)
#
# Get the Name of the AdminServer of Domain 
def getAdminServerName():
  serverConfig()
  cd('/')
  adminServerName=cmo.getAdminServerName()
  return adminServerName
#
# Get the Servers of Domain 
def getDomainServers():
  print(lineSeperator)
  print('\nGet Servers from domain')
  serverConfig()
  cd("/")
  servers = cmo.getServers()
  return servers
#
# Get the Servers of Cluster 
def getClusterServers(clustername):
  #Cluster config to be fetched from ServerConfig
  print(lineSeperator)
  print('\nGet Servers from cluster '+clustername)
  serverConfig()
  cluster = getMBean("/Clusters/" + clustername)
  if cluster is None:
    errorMsg= "Cluster " + clustername + " does not appear to exist!"
    print errorMsg
    raise(Exception(errorMsg))
  print "Found cluster "+ clustername+ "."
  servers = cluster.getServers()
  return servers
#
# Get the Domain Clusters 
def getClusters():
  #Cluster config to be fetched from ServerConfig
  print(lineSeperator)
  print('\nGet Clusters')
  cd('/')
  clusters = cmo.getClusters()
  return clusters
#
# Get status of a server
def serverStatus(serverName):
  serverRuntime=getMBean('/ServerRuntimes/'+serverName)
  if serverRuntime is None:
    print("Server Runtime for  " + serverName + " not found, server apparently SHUTDOWN")
    serverState="SHUTDOWN"
  else:
    print "Found Server Runtime for "+ serverName+ "."
    serverState = serverRuntime.getState()
  return serverState
#
# Start Server
# Expected to be in domainRuntime to get to the serverRuntimes.
def startMServer(serverName):
  print(lineSeperator)
  print('ServerName: '+serverName)
  serverState = serverStatus(serverName)
  print('Server '+serverName+': '+serverState)
  if serverState=="SHUTDOWN":
    print ('Server '+serverName+' is not running so start it.')
    start(serverName,'Server')
  elif serverState=="RUNNING":
    print ('Server '+serverName+' is already running')
  else:
    print ('Server '+serverName+' in state '+serverState+', not startable!')
#
# Start servers in a cluster one by one.
def startMServers(serverList):
  print(lineSeperator)
  print ('Start servers from list: '+serverList)
  servers=serverList.split(',')
  # Need to go to domainRuntime to get to the serverRuntimes.
  domainRuntime()
  #
  for serverName in servers:
    startMServer(serverName)
  #
  print ('\nFinished starting servers.')
#
# Start servers in a cluster one by one.
def startClusterServers(clusterName):
  print(lineSeperator)
  print ('Start servers for cluster: '+clusterName)
  servers=getClusterServers(clusterName)
  # Need to go to domainRuntime to get to the serverRuntimes.
  domainRuntime()
  #
  for server in servers:
    serverName = server.getName()
    startMServer(serverName)
  #
  print ('\nFinished starting servers.')
#
# Start servers in domain one by one.
def startDomainServers():
  print(lineSeperator)
  print ('Start servers for domain')
  servers=getDomainServers()
  adminServerName=getAdminServerName()
  # Need to go to domainRuntime to get to the serverRuntimes.
  domainRuntime()
  #
  for server in servers:
    serverName = server.getName()
    if (serverName!=adminServerName):
      startMServer(serverName)
    else:
      print('Skip '+adminServerName)
  #
  print ('\nFinished starting servers.')
#
# Stop Server
# Expected to be in domainRuntime to get to the serverRuntimes.
def stopMServer(serverName):
  print(lineSeperator)
  print('ServerName: '+serverName)
  serverState = serverStatus(serverName)
  print('Server '+serverName+': '+serverState)
  if serverState=="RUNNING":
    print ('Server '+serverName+' is running so shut it down.')
    shutdown(name=serverName, entityType='Server', force='true')
  elif serverState=="SHUTDOWN":
    print ('Server '+serverName+' is already down.')
  else:
    print ('Server '+serverName+' in state '+serverState+', but try to stop it!')
    shutdown(name=serverName, entityType='Server', force='true')
#
# Stop servers in a list
def stopMServers(serverList):
  print(lineSeperator)
  print ('Stop servers from list: '+serverList)
  servers=serverList.split(',')
  # Need to go to domainRuntime to get to the serverRuntimes.
  domainRuntime()
  #
  for serverName in servers:
    stopMServer(serverName)
  #
  print ('\nFinished stopping servers.')
#
# Stop servers in a cluster one by one.
def stopClusterServers(clusterName):
  print(lineSeperator)
  print ('Stop servers for cluster: '+clusterName)
  servers=getClusterServers(clusterName)
  # Need to go to domainRuntime to get to the serverRuntimes.
  domainRuntime()
  #
  for server in servers:
    serverName = server.getName()
    stopMServer(serverName)
  #
  print ('\nFinished stopping servers.')
#
# Stop servers in a domain one by one.
def stopDomainServers():
  print(lineSeperator)
  print ('Stop servers for domain')
  servers=getDomainServers()
  adminServerName=getAdminServerName()
  # Need to go to domainRuntime to get to the serverRuntimes.
  domainRuntime()
  #
  for server in servers:
    serverName = server.getName()
    if (serverName!=adminServerName):
      stopMServer(serverName)
    else:
      print('Skip '+adminServerName)
  #
  print ('\nFinished stopping servers.')
#
# Start cluster
def startCluster(clusterName):
  print(lineSeperator)
  print ('Start cluster: '+clusterName)
  try:
    start(clusterName,'Cluster')
  except WLSTException:
    print "Apparently Cluster in incompatible state!", sys.exc_info()[0], sys.exc_info()[1]
    startClusterServers(clusterName)
  state(clusterName,'Cluster')
  #
  print ('\nFinished starting cluster '+clusterName)
#
# Start clusters in a list
def startClusters(clusterList):
  print(lineSeperator)
  print ('Start clusters from list: '+clusterList)
  clusters=clusterList.split(',')
  #
  for clusterName in clusters:
    startCluster(clusterName)
  #
  print ('\nFinished starting clusters.')
#
# Start clusters
def startDomainClusters():
  print(lineSeperator)
  print ('Start clusters')
  clusters=getClusters()
  #
  for cluster in clusters:
    clusterName = cluster.getName()
    startCluster(clusterName)
  #
  print ('\nFinished starting clusters.')
#
# Stop cluster
def stopCluster(clusterName):
  print(lineSeperator)
  print ('Stop cluster: '+clusterName)
  try:
    #shutdown(clusterName,'Cluster')
    shutdown(name=serverName, entityType='Cluster', force='true')
    state(clusterName,'Cluster')
  except WLSTException:
    print "Apparently Cluster in incompatible state!", sys.exc_info()[0], sys.exc_info()[1]
    state(clusterName,'Cluster')
    print ('Try to stop servers for cluster: '+clusterName+', one by one')
    stopClusterServers(clusterName)
  #
  print ('\nFinished stopping cluster '+clusterName)
#
# Stop clusters in a list
def stopClusters(clusterList):
  print(lineSeperator)
  print ('Stop clusters from list: '+clusterList)
  clusters=clusterList.split(',')
  #
  for clusterName in clusters:
    stopCluster(clusterName)
  #
  print ('\nFinished stopping clusters.')
#
# Stop all clusters of the domain
def stopDomainClusters():
  print(lineSeperator)
  print ('Stop clusters')
  clusters=getClusters()
  #
  for cluster in clusters:
    clusterName = cluster.getName()
    stopCluster(clusterName)
  #
  print ('\nFinished stopping clusters.')
#
# StopAdmin
def stopAdmin():
  print(lineSeperator)
  print('Stop '+adminServerName)
  shutdown(force='true')
  serverState = serverStatus(serverName)
  print('State '+adminServerName+': '+ serverState)
  print('\nFinished stopping AdminServer: '+adminServerName)
#
# Start admin Server
def startAdmin():
  print(lineSeperator)
  print('Start and connect to '+adminServerName)
  connectToAdminServer(adminUrl, adminServerName)
  print('\nFinished starting AdminServer: '+adminServerName)
#
# Stop a domain
def stopDomain():
  print (lineSeperator)
  stopDomainClusters()
  #
  stopAdmin()
  print ('\nFinished stopping domain.')
  #
#
# Start a Domain
def startDomain():
  print (lineSeperator)
  #
  startAdmin()
  #
  startDomainClusters()
  #
  print ('\nFinished starting domain.')
  #
#
# (Re-)Start or Stop Domain
def startStopDomain(startStopOption):
  if startStopOption=="stop" or startStopOption=="restart":
    stopDomain()
  if startStopOption=="start" or startStopOption=="restart":
     startDomain()
#
# (Re-)Start or Stop Admin
def startStopAdmin(startStopOption):
  if startStopOption=="stop" or startStopOption=="restart":
    stopAdmin()
  if startStopOption=="start" or startStopOption=="restart":
     startAdmin()
#
# (Re-)Start or Stop Clusters
def startStopClusters(startStopOption, clusterList):
  if startStopOption=="stop" or startStopOption=="restart":
    if clusterList is None:
      stopDomainClusters()
    else:
      stopClusters(clusterList)
  if startStopOption=="start" or startStopOption=="restart":
    if clusterList is None:
      startDomainClusters()
    else:
      startClusters(clusterList)
#
# (Re-)Start or Stop Servers
def startStopServers(startStopOption, serverList):
  if startStopOption=="stop" or startStopOption=="restart":
    if serverList is None:
      stopDomainServers()
    else:
      stopMServers(serverList)
  if startStopOption=="start" or startStopOption=="restart":
    if serverList is None:
      startDomainServers()
    else:
      startMServers(serverList)
#
# Main
def main():
  try:
    print ('Args passed: '+ str(len(sys.argv) ))
    componentList = None
    idx = 0
    for arg in sys.argv:
      if idx == 0:
        print 'ScriptName: '+arg
      elif idx == 1:
        # startStopOption: start, stop, restart
        startStopOption=arg
      elif idx == 2:
        # componentType: AdminSvr, Domain, Clusters, Servers
        componentType=arg
      elif idx == 3:
        componentList=arg
      else:
        componentList = componentList+','+arg
      idx=idx+1
    #
    #componentName=sys.argv[3]
    # Set wlsDomainHome
    wlsDomainHome = wlsDomainsHome+'/'+wlsDomainName
    #
    print(lineSeperator)
    if componentList is None:
      componentStr = componentType
    else:
      componentStr = componentType+' '+componentList
    if startStopOption=="start" or startStopOption=="restart":
      print('(Re)Start '+componentStr+' in '+wlsDomainHome+', with option '+startStopOption)
    elif startStopOption=="stop":
      print('Stop '+componentStr+' in '+wlsDomainHome+', with option '+startStopOption)
    else:
      raise Exception("Unkown startStopOption: "+ startStopOption)
    #
    print(lineSeperator)
    print('\nConnect to the AdminServer: '+adminServerName)
    connectToAdminServer(adminUrl, adminServerName)
    #
    print('Connected, so proceed with: '+startStopOption+' of '+componentType)
    #
    if componentType=="AdminSvr":
      startStopAdmin(startStopOption)
    elif componentType=="Domain":
      startStopDomain(startStopOption)
    elif componentType=="Clusters":
      startStopClusters(startStopOption, componentList)
    elif componentType=="Servers":
      startStopServers(startStopOption, componentList)
    else:
      raise Exception('Undefined componentType: '+componentType);
    #
    print('\nExiting...')
    exit()
  except NameError, e:
    print('Apparently properties not set.')
    print "Please check the property: ", sys.exc_info()[0], sys.exc_info()[1]
    usage()
  except:
    apply(traceback.print_exception, sys.exc_info())
    exit(exitcode=1)
#call main()
main()
exit()