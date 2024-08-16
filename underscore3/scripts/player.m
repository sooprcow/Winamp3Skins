// Script by: David Serrano
//            SOOPRcow@deskmod.com

#include "../../../lib/std.mi"
//#include "defines.m"

Global Text songDisplay, shadeSongDisplay;
Global Timer toggleVolumeDsp;
Global Group eqGroup;
Global Button eqButton;

system.onScriptLoaded() {
	Group songDspGroup = getContainer("main").getLayout("normal").getObject("group.player.song");
	songDisplay = songDspGroup.getObject("display.song.ticker");
	Group shadeSongDspGroup = getContainer("main").getLayout("shade").getObject("group.player.shade.song");
	shadeSongDisplay = shadeSongDspGroup.getObject("shade.songticker");
	toggleVolumeDsp = new Timer;
	toggleVolumeDsp.setDelay(1500);
	eqGroup = getContainer("main").getLayout("normal").getObject("group.equalizer");
	Group winControls = getContainer("main").getLayout("normal").getObject("group.player.buttons.windows");
	eqButton = winControls.getObject("buttons.eq");
}

system.onVolumeChanged(int newvol) {
	songDisplay.setXmlParam("display","");
	songDisplay.setXmlParam("default","Volume: " + integerToString((newvol / 255) * 100) + "%");
	shadeSongDisplay.setXmlParam("display","");
	shadeSongDisplay.setXmlParam("default","Volume: " + integerToString((newvol / 255) * 100) + "%");	
	toggleVolumeDsp.stop();
	toggleVolumeDsp.start();
}

toggleVolumeDsp.onTimer() {
	songDisplay.setXmlParam("display","songname");
	songDisplay.setXmlParam("default","");
	shadeSongDisplay.setXmlParam("display","songname");
	shadeSongDisplay.setXmlParam("default","");
	toggleVolumeDsp.stop();
}

eqButton.onLeftButtonUp(int x, int y) {
	eqGroup.setTargetW(166);
	eqGroup.setTargetH(67);
	eqGroup.setTargetSpeed(0);
	eqGroup.gotoTarget();
}