#############################################################################
# Start OHS via NodeManager.
#
# @author Martien van den Akker, Darwin-IT Professionals
# @version 1.0, 2017-03-01
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
  print "adminUrl=localhost:7101"
  print "adminUser=weblogic"
  print "adminPwd=welcome1"
# 
#
def connectToNM(nmHost, nmPort, nmHome, wlsDomainName, wlsDomainHome, nmType):
  try:
    print(lineSeperator)
    print('Try to connect to the Node Manager')
    #nmConnect(username=adminUser, password=adminPwd, host=nmHost, port=nmPort, domainName=wlsDomainName, domainDir=wlsDomainHome, nmType=nmType)
    nmConnect(userConfigFile=usrCfgFile, userKeyFile=usrKeyFile, host=nmHost, port=nmPort, domainName=wlsDomainName, domainDir=wlsDomainHome, nmType=nmType)
    print('Connected to the Node Mananger')
  except WLSTException:
    message='Apparently NodeManager not Started!'
    print (message)
    raise Exception(message)
#
#
def getSystemComponents(wlsDomainHome):
  try:
    print(lineSeperator)
    print('Get SystemComponents')
    try:
      sysComps=ohsComponents.split(',')
    except NameError, e:
      print 'Property ohsComponents not set, read from Domain'
      print('Read domain from : '+wlsDomainHome)
      readDomain(wlsDomainHome)
      cd('/SystemComponent')
      sysComps=ls(returnMap='true')
    return sysComps
  except WLSTException:
    message='Exception getting SystemComponents'
    print (message)
    raise Exception(message)
#
# Start a System Component
def startSystemComponent(sysComp):
  try:
    print(lineSeperator)
    print('StartSystemComponent '+sysComp)
    nmStart(serverName=sysComp, serverType='OHS')
  except WLSTException:
    message='Exception starting SystemComponent: '+sysComp
    print (message)
    raise Exception(message)
#
# Stop a System Component
def stopSystemComponent(sysComp):
  try:
    print(lineSeperator)
    print('StartSystemComponent '+sysComp)
    nmKill(serverName=sysComp, serverType='OHS')
  except WLSTException:
    message='Exception stopping SystemComponent: '+sysComp
    print (message)
    raise Exception(message)
#
# Start, restart or stop System Components, based on startStopOption.
def startStopSystemComponents(startStopOption, sysComps):
  try:
    print(lineSeperator)
    print('StartSystemComponents')
    if startStopOption=="stop" or startStopOption=="restart":
      for sysComp in sysComps:
        stopSystemComponent(sysComp)
    if startStopOption=="start" or startStopOption=="restart":
      for sysComp in sysComps:
        startSystemComponent(sysComp)
  except WLSTException:
    message='Exception starting or stopping SystemComponents, startStopOption:'+startStopOption
    print (message)
    raise Exception(message)
#
#
def main():
  try:
    startStopOption=sys.argv[1]
    wlsDomainHome = wlsDomainsHome+'/'+wlsDomainName
    print(lineSeperator)
    if startStopOption=="start" or startStopOption=="restart":
      print('(Re)Start OHS for domain in : '+wlsDomainHome+', with option '+startStopOption)
    else:
      print('Stop OHS for domain in : '+wlsDomainHome+', with option '+startStopOption)
    print(lineSeperator)
    print ('Connect to the Node Manager')
    connectToNM(nmHost, nmPort, nmHome, wlsDomainName, wlsDomainHome, nmType)
    #
    systemComponents=getSystemComponents(wlsDomainHome)
    #
    startStopSystemComponents(startStopOption, systemComponents)
    
  except NameError, e:
    print('Apparently properties not set.')
    print "Please check the property: ", sys.exc_info()[0], sys.exc_info()[1]
    usage()
  except:
    apply(traceback.print_exception, sys.exc_info())
    exit(exitcode=1)
#
main();
