// Script by: David Serrano
//            SOOPRcow@deskmod.com

#include "../../../../../lib/std.mi"

Global Slider objSlider;
Global Group grpFill;

function setSlidePosition(int val);

system.onScriptLoaded() {
 objSlider = getScriptGroup().getObject("objslider");
 grpFill = getScriptGroup().getObject("custom.hslider.fill");
}

objSlider.onSetPosition(int newpos) {
 setSlidePosition(newpos);
}

objSlider.onPostedPosition(int newpos) {
 setSlidePosition(newpos);
}

objSlider.onSetFinalPosition(int pos) {
 setSlidePosition(newpos);
}

setSlidePosition(int val) {
 int nw = (val / 2.55) * (objSlider.getWidth() * 0.01);
 grpFill.setXmlParam("w",integerToString(nw-1));
}

system.onStop() {
 grpFill.setXmlParam("w","0");
}