// Script by: David Serrano
//            SOOPRcow@deskmod.com

#include "../../lib/std.mi"
#include "defines.m"

Global ToggleButton visToggle, visType;
Global Slider alphaSlider;
Global Layer alphaGhost;
Global Text alphaText;
Global Layout visNotify;


system.onScriptLoaded() {
	visNotify = getContainer("main").getLayout("normal");
	Group gFrame = getScriptGroup();
	// Toggle Vis Setup
	visToggle = gFrame.getObject("vis.toggle");
	visToggle.setActivatedNoCallback(getPrivateInt(SKIN_NAME,"vison",true));
	// Toggle Vis Type Setup
	visType = gFrame.getObject("type.toggle");
	visType.setActivatedNoCallback(getPrivateInt(SKIN_NAME,"vistype",VIS_BARS));
	// Alpha Slider Setup
	alphaSlider = gFrame.getObject("slide.alpha");
	alphaGhost = gFrame.getObject("slide.alpha.ghost");
	alphaText = gFrame.getObject("cur.alpha");
	int alphaPer = getPrivateInt(SKIN_NAME,"maxvisfadealpha",25);
	alphaSlider.setPosition(alphaPer * 2.55);
	alphaGhost.setXmlParam("w",integerToString((alphaPer * 77) / 100));
	alphaText.setText(integerToString(alphaPer) + "%");
	
}

visToggle.onToggle(boolean state) {
	setPrivateInt(SKIN_NAME,"vison",state);
	visNotify.onNotify("vison",integerToString(state),0,0);
}

visType.onToggle(boolean state) {
	setPrivateInt(SKIN_NAME,"vistype",state);
	visNotify.onNotify("vistype",integerToString(state),0,0);
}

alphaSlider.onSetFinalPosition(int pos) {
	visNotify.onNotify("visalpha",integerToString(pos / 2.55),0,0);
	setPrivateInt(SKIN_NAME,"maxvisfadealpha",(pos / 2.55));
}

alphaSlider.onSetPosition(int newpos) {
	int percent = newpos / 2.55;
	alphaGhost.setXmlParam("w",integerToString((percent * 77) / 100));
	alphaText.setText(integerToString(percent) + "%");
	visNotify.onNotify("visalpha",integerToString(newpos / 2.55),0,0);
}