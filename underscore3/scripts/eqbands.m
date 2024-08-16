// Script by: David Serrano
//            SOOPRcow@deskmod.com

#include "../../../lib/std.mi"
//#include "defines.m"

function eqBarUpdate(AnimatedLayer eqBar, int newval);

Global AnimatedLayer eqPreAmp,eqBar1,eqBar2,eqBar3,eqBar4,eqBar5,eqBar6,eqBar7,eqBar8,eqBar9,eqBar10;
Global Button eqClose;

system.onScriptLoaded() {
	Group eqGroup = getContainer("main").getLayout("normal").getObject("group.equalizer");
	eqClose = eqGroup.getObject("eq.close");
	eqPreAmp = eqGroup.getObject("eq.preamp.ani");
	eqBar1 = eqGroup.getObject("eq.bar1.ani");
	eqBar2 = eqGroup.getObject("eq.bar2.ani");
	eqBar3 = eqGroup.getObject("eq.bar3.ani");
	eqBar4 = eqGroup.getObject("eq.bar4.ani");
	eqBar5 = eqGroup.getObject("eq.bar5.ani");
	eqBar6 = eqGroup.getObject("eq.bar6.ani");
	eqBar7 = eqGroup.getObject("eq.bar7.ani");
	eqBar8 = eqGroup.getObject("eq.bar8.ani");
	eqBar9 = eqGroup.getObject("eq.bar9.ani");
	eqBar10 = eqGroup.getObject("eq.bar10.ani");

	eqBarUpdate(eqPreAmp, getEqPreamp());
	eqBarUpdate(eqBar1, getEqBand(0));
	eqBarUpdate(eqBar2, getEqBand(1));
	eqBarUpdate(eqBar3, getEqBand(2));
	eqBarUpdate(eqBar4, getEqBand(3));
	eqBarUpdate(eqBar5, getEqBand(4));
	eqBarUpdate(eqBar6, getEqBand(5));
	eqBarUpdate(eqBar7, getEqBand(6));
	eqBarUpdate(eqBar8, getEqBand(7));
	eqBarUpdate(eqBar9, getEqBand(8));
	eqBarUpdate(eqBar10, getEqBand(9));
}

system.onEqPreampChanged(int newval) {
        eqBarUpdate(eqPreAmp, newval);
}

system.onEqBandChanged(int band, int newval) {
	if (band == 0) eqBarUpdate(eqBar1, newval);
	if (band == 1) eqBarUpdate(eqBar2, newval);
	if (band == 2) eqBarUpdate(eqBar3, newval);
	if (band == 3) eqBarUpdate(eqBar4, newval);
	if (band == 4) eqBarUpdate(eqBar5, newval);
	if (band == 5) eqBarUpdate(eqBar6, newval);
	if (band == 6) eqBarUpdate(eqBar7, newval);
	if (band == 7) eqBarUpdate(eqBar8, newval);
	if (band == 8) eqBarUpdate(eqBar9, newval);
	if (band == 9) eqBarUpdate(eqBar10, newval);
}

eqClose.onLeftButtonUp(int x, int y) {
	Group eqGroup = getContainer("main").getLayout("normal").getObject("group.equalizer");
	eqGroup.setTargetW(0);
	eqGroup.setTargetSpeed(0);
	eqGroup.gotoTarget();
}

eqBarUpdate(AnimatedLayer eqBar, int newval) {
	eqBar.goToFrame(((newval + 128) * (eqBar.getLength() -1)) / 255);
}