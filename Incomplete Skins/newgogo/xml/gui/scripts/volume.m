// Script by: David Serrano
//            SOOPRcow@deskmod.com

#include "../../../../../lib/std.mi"

Global Slider objVolume;
Global GuiObject rectFill;
Global Timer tSet;

function setSlidePosition(int val);

system.onScriptLoaded() {
 objVolume = getScriptGroup().getObject("objvolume");
 rectFill = getScriptGroup().getObject("fill");
 tSet = new Timer;
 tSet.setDelay(10);
 tSet.start();
}

tSet.onTimer() {
 setSlidePosition(getVolume());
 tSet.Stop();
}

system.onVolumeChanged(int val) {
 setSlidePosition(val);
}

setSlidePosition(int val) {
 int nw = (val / 2.55) * (objVolume.getWidth() * 0.01);
 rectFill.setXmlParam("w",integerToString(nw-1));
}