<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<AutomatedInstallation langpack="eng">
    <com.jboss.devstudio.core.installer.HTMLInfoPanelWithRootWarning id="introduction"/>
    <com.izforge.izpack.panels.HTMLLicencePanel id="licence"/>
    <com.jboss.devstudio.core.installer.PathInputPanel id="target">
        <installpath>$RHCRS_HOME</installpath>
    </com.jboss.devstudio.core.installer.PathInputPanel>
    <com.jboss.devstudio.core.installer.JREPathPanel id="jre"/>
    <com.jboss.devstudio.core.installer.JBossAsSelectPanel id="as">
        <installgroup>devstudio</installgroup>
    </com.jboss.devstudio.core.installer.JBossAsSelectPanel>
    <com.jboss.devstudio.core.installer.InstallAdditionalFeaturesPanel id="features">
        <ius>com.jboss.devstudio.core.package,org.testng.eclipse.feature.group,com.jboss.devstudio.fuse.feature.feature.group</ius>
        <locations>devstudio</locations>
    </com.jboss.devstudio.core.installer.InstallAdditionalFeaturesPanel>
    <com.jboss.devstudio.core.installer.InstallAdditionalRuntimesPanel id="runtimes">
        <locations/>
    </com.jboss.devstudio.core.installer.InstallAdditionalRuntimesPanel>
    <com.jboss.devstudio.core.installer.UpdatePacksPanel id="updatepacks"/>
    <com.jboss.devstudio.core.installer.DiskSpaceCheckPanel id="diskspacecheck"/>
    <com.izforge.izpack.panels.SummaryPanel id="summary"/>
    <com.izforge.izpack.panels.InstallPanel id="install"/>
    <com.jboss.devstudio.core.installer.CreateLinkPanel id="createlink">
        <jrelocation>/etc/alternatives/java_sdk/bin/java</jrelocation>
    </com.jboss.devstudio.core.installer.CreateLinkPanel>
    <com.izforge.izpack.panels.ShortcutPanel id="shortcut">
        <programGroup name=""/>
        <shortcut KdeSubstUID="false" categories="Applications;Development;" commandLine="" createForAll="true" description="Runs the Red Hat CodeReady Studio ${RHCRS_VERSION}.GA" encoding="UTF-8" group="true" icon="$RHCRS_HOME/studio/48-studio.icon.png" iconIndex="0" initialState="1" mimetype="" name="Red Hat CodeReady Studio ${RHCRS_VERSION}.GA" target="$RHCRS_HOME/studio/codereadystudio" terminal="false" terminalOptions="" tryexec="" type="Application" url="" usertype="0" workingDirectory="$RHCRS_HOME/studio"/>
        <shortcut KdeSubstUID="false" categories="Applications;Development;" commandLine="-jar &quot;$RHCRS_HOME/Uninstaller/uninstaller.jar&quot;" createForAll="true" description="Uninstall Red Hat CodeReady Studio ${RHCRS_VERSION}.GA" encoding="UTF-8" group="true" icon="$RHCRS_HOME/studio/48-uninstall.icon.png" iconIndex="0" initialState="1" mimetype="" name="Uninstall Red Hat CodeReady Studio ${RHCRS_VERSION}.GA" target="java" terminal="false" terminalOptions="" tryexec="" type="Application" url="" usertype="0" workingDirectory="$RHCRS_HOME/Uninstaller"/>
    </com.izforge.izpack.panels.ShortcutPanel>
    <com.jboss.devstudio.core.installer.ShortcutPanelPatch id="shortcutpatch"/>
    <com.izforge.izpack.panels.SimpleFinishPanel id="finish"/>
</AutomatedInstallation>
