// Script by: David Serrano
//            SOOPRcow@deskmod.com

#include "../../lib/std.mi"
#include "../../lib/config.mi"
#include "defines.m"

Global AnimatedLayer vis1, vis2, vis3, vis4, vis5, vis6, vis7, vis8, vis9, vis10, vis11, vis12, vis13, vis14, vis15, vis16, vis17;
Global int vis2val, vis3val, vis4val, vis5val, vis6val, vis7val, vis8val, vis9val, vis10val, vis11val, vis12val, vis13val, vis14val, vis15val, vis16val;
Global Timer visUpdate;
Global ConfigAttribute visRate;
Global Layout nLayout;
Global int visMode, visAlpha;

function _resetAlpha(int alpha);
function _resetBars(int frame);

system.onScriptLoaded() {
	nLayout = getContainer("main").getLayout("normal");
	Group visGroup = nLayout.getObject("group.left.panel");
	vis1  = visGroup.getObject("visbar1");
	vis2  = visGroup.getObject("visbar2");
	vis3  = visGroup.getObject("visbar3");
	vis4  = visGroup.getObject("visbar4");
	vis5  = visGroup.getObject("visbar5");
	vis6  = visGroup.getObject("visbar6");
	vis7  = visGroup.getObject("visbar7");
	vis8  = visGroup.getObject("visbar8");
	vis9  = visGroup.getObject("visbar9");
	vis10 = visGroup.getObject("visbar10");
	vis11 = visGroup.getObject("visbar11");
	vis12 = visGroup.getObject("visbar12");
	vis13 = visGroup.getObject("visbar13");
	vis14 = visGroup.getObject("visbar14");
	vis15 = visGroup.getObject("visbar15");
	vis16 = visGroup.getObject("visbar16");
	vis17 = visGroup.getObject("visbar17");
	vis2val = 0; vis3val = 0; vis4val = 0; vis5val = 0; vis6val = 0; vis7val = 0; vis8val = 0; vis9val = 0; vis10val = 0; vis11val = 0; vis12val = 0; vis13val = 0; vis14val = 0; vis15val = 0; vis16val = 0;
	visMode = getPrivateInt(SKIN_NAME,"vistype",VIS_BARS);
	if (visMode == VIS_BARS) {
		_resetAlpha(getPrivateInt(SKIN_NAME,"maxvisfadealpha",20) * 2.55);
	}
	visAlpha = getPrivateInt(SKIN_NAME,"maxvisfadealpha",20) * 2.55;
	// Setup Timer
	visUpdate = New Timer;
	configItem configSection = config.getItem("Skins and UI Tweaks");
	visRate = configSection.getAttribute("Multiplexed timers resolution");
 	if (visRate != NULL) {
		visUpdate.setDelay(stringToInteger(visRate.getData()) + 20);
	} else {
		visUpdate.setDelay(50);
	}
	if (System.getStatus() == 1 && getPrivateInt(SKIN_NAME,"vison",true) == true) {
		visUpdate.start();
	}
}

visRate.onDataChanged() {
	visUpdate.setDelay(stringToInteger(visRate.getData()) + 20);
}

system.onPlay() { visUpdate.start(); }
system.onResume() {visUpdate.start(); }
system.onStop() { 
	visUpdate.stop();
	vis2val = 0; vis3val = 0; vis4val = 0; vis5val = 0; vis6val = 0; vis7val = 0; vis8val = 0; vis9val = 0; vis10val = 0; vis11val = 0; vis12val = 0; vis13val = 0; vis14val = 0; vis15val = 0; vis16val = 0;
	visUpdate.onTimer();
}
system.onPause() { VisUpdate.stop(); }

visUpdate.onTimer() {
	if (visMode == VIS_BARS) {
		int numFrames = (vis9.getLength() - 1);
		// Get Old Bar Values.
		// We don't need the values of bars 1 and 16 because they aren't used
		int old2val = vis2val;
		int old3val = vis3val;
		int old4val = vis4val;
		int old5val = vis5val;
		int old6val = vis6val;
		int old7val = vis7val;
		int old8val = vis8val;
		int old9val = vis9val;
		int old10val = vis10val;
		int old11val = vis11val;
		int old12val = vis12val;
		int old13val = vis13val;
		int old14val = vis14val;
		int old15val = vis15val;
		int old16val = vis16val;
		// Get The current VU meter values
		int centerVu = (system.getLeftVuMeter() + system.getRightVuMeter()) / 2;
		// Update Center Bar
		vis9.gotoFrame((centerVu * numFrames) / 255); vis9val = centerVu;
		// Update Each Bar Values from Center to Left Then Save Values
		vis8.gotoFrame((old9val * numFrames) / 255); vis8val = old9val;
		vis7.gotoFrame((old8val * numFrames) / 255); vis7val = old8val;
		vis6.gotoFrame((old7val * numFrames) / 255); vis6val = old7val;
		vis5.gotoFrame((old6val * numFrames) / 255); vis5val = old6val;
		vis4.gotoFrame((old5val * numFrames) / 255); vis4val = old5val;
		vis3.gotoFrame((old4val * numFrames) / 255); vis3val = old4val;
		vis2.gotoFrame((old3val * numFrames) / 255); vis2val = old3val;
		vis1.gotoFrame((old2val * numFrames) / 255);
	
		// Update Right Bar Values from Center to Right Then Save Values
		vis10.gotoFrame((old9val * numFrames) / 255); vis10val = old9val;
		vis11.gotoFrame((old10val * numFrames) / 255); vis11val = old10val;
		vis12.gotoFrame((old11val * numFrames) / 255); vis12val = old11val;
		vis13.gotoFrame((old12val * numFrames) / 255); vis13val = old12val;
		vis14.gotoFrame((old13val * numFrames) / 255); vis14val = old13val;
		vis15.gotoFrame((old14val * numFrames) / 255); vis15val = old14val;
		vis16.gotoFrame((old15val * numFrames) / 255); vis16val = old15val;
		vis17.gotoFrame((old16val * numFrames) / 255);
	} else {
		int numFrames = (vis9.getLength() - 1);
		// Get Old Bar Values.
		// We don't need the values of bars 1 and 16 because they aren't used
		int old2val = vis2val;
		int old3val = vis3val;
		int old4val = vis4val;
		int old5val = vis5val;
		int old6val = vis6val;
		int old7val = vis7val;
		int old8val = vis8val;
		int old9val = vis9val;
		int old10val = vis10val;
		int old11val = vis11val;
		int old12val = vis12val;
		int old13val = vis13val;
		int old14val = vis14val;
		int old15val = vis15val;
		int old16val = vis16val;
		// Get The current VU meter values
		int maxAlphaBars = visAlpha / 2.55;
		if (maxAlphaBars > 100) maxAlphaBars = 100;
		if (maxAlphaBars < 0) maxAlphaBars = 0;
		int centerVu = (((system.getLeftVuMeter() + system.getRightVuMeter()) / 2) * maxAlphaBars) / 100;
		// Set All Bars to last frame
		vis1.gotoFrame(numFrames); vis1.setAlpha(old2val);
		vis2.gotoFrame(numFrames); vis2.setAlpha(old3val); vis2val = old3val;
		vis3.gotoFrame(numFrames); vis3.setAlpha(old4val); vis3val = old4val;
		vis4.gotoFrame(numFrames); vis4.setAlpha(old5val); vis4val = old5val;
		vis5.gotoFrame(numFrames); vis5.setAlpha(old6val); vis5val = old6val;
		vis6.gotoFrame(numFrames); vis6.setAlpha(old7val); vis6val = old7val;
		vis7.gotoFrame(numFrames); vis7.setAlpha(old8val); vis7val = old8val;
		vis8.gotoFrame(numFrames); vis8.setAlpha(old9val); vis8val = old9val;
		vis9.gotoFrame(numFrames); vis9.setAlpha(centerVu); vis9val = centerVu;
		vis10.gotoFrame(numFrames); vis10.setAlpha(old9val); vis10val = old9val;
		vis11.gotoFrame(numFrames); vis11.setAlpha(old10val); vis11val = old10val;
		vis12.gotoFrame(numFrames); vis12.setAlpha(old11val); vis12val = old11val;
		vis13.gotoFrame(numFrames); vis13.setAlpha(old12val); vis13val = old12val;
		vis14.gotoFrame(numFrames); vis14.setAlpha(old13val); vis14val = old13val;
		vis15.gotoFrame(numFrames); vis15.setAlpha(old14val); vis15val = old14val;
		vis16.gotoFrame(numFrames); vis16.setAlpha(old15val); vis16val = old15val;
		vis17.gotoFrame(numFrames); vis17.setAlpha(old16val);
	}
}

nLayout.onNotify(String command, String param, int a, int b) {
	if (command == "vison") {
		if (param == "0") {
			visUpdate.stop();
			_resetBars(0);
		} else {
			visUpdate.start();
		}
	}
	if (command == "vistype") {
		if (param == "0") {
			int maxAlphaBars = getPrivateInt(SKIN_NAME,"maxvisfadealpha",20);
			_resetAlpha(maxAlphaBars * 2.55);
			visMode = VIS_BARS;
		} else {
			visMode = VIS_FADE;
		}
	}
	if (command == "visalpha") {
		visAlpha = stringToInteger(param) * 2.55;
		if (visMode == VIS_BARS) {
			_resetAlpha(visAlpha);
		}
	}			
}

_resetAlpha(int alpha) {
	vis1.setAlpha(alpha);
	vis2.setAlpha(alpha);
	vis3.setAlpha(alpha);
	vis4.setAlpha(alpha);
	vis5.setAlpha(alpha);
	vis6.setAlpha(alpha);
	vis7.setAlpha(alpha);
	vis8.setAlpha(alpha);
	vis9.setAlpha(alpha);
	vis10.setAlpha(alpha);
	vis11.setAlpha(alpha);
	vis12.setAlpha(alpha);
	vis13.setAlpha(alpha);
	vis14.setAlpha(alpha);
	vis15.setAlpha(alpha);
	vis16.setAlpha(alpha);
	vis17.setAlpha(alpha);
}

_resetBars(int frame) {
	vis1.gotoFrame(frame);
	vis2.gotoFrame(frame);
	vis3.gotoFrame(frame);
	vis4.gotoFrame(frame);
	vis5.gotoFrame(frame);
	vis6.gotoFrame(frame);
	vis7.gotoFrame(frame);
	vis8.gotoFrame(frame);
	vis9.gotoFrame(frame);
	vis10.gotoFrame(frame);
	vis11.gotoFrame(frame);
	vis12.gotoFrame(frame);
	vis13.gotoFrame(frame);
	vis14.gotoFrame(frame);
	vis15.gotoFrame(frame);
	vis16.gotoFrame(frame);
	vis17.gotoFrame(frame);
}