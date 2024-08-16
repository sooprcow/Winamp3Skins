// Script by: David Serrano
//            SOOPRcow@deskmod.com

#include "../../../lib/std.mi"
#define SKIN_NAME "deepsmooth3"

// Seek Bar Objects
Global Slider seek;
Global Layer seekFill;

// Display Text/Timer Objects
Global Timer displayTxtTimer;
Global Text displayTxt;
Global Int seeking;

function setDisplayTxt(String txt);

system.onScriptLoaded() {
 Layout lMain = getContainer("main").getLayout("normal");
 
 Group seekGroup = lMain.getObject("group.seekbar");
 seek = seekGroup.getObject("seek");
 seekFill = seekGroup.getObject("seekfill");

 Group songGroup = lMain.getObject("group.songinfo");
 displayTxt = songGroup.getObject("song");
 displayTxtTimer = new Timer;
 displayTxtTimer.setDelay(1250);
}

seek.onLeftButtonDown(int x, int y) {
 seeking = true;
}

seek.onLeftButtonUp(int x, int y) {
 seeking = false;
}

seek.onSetPosition(int val) {
 int nw = ((val / 2.55) * 2.52);
 seekFill.setXmlParam("w",integerToString(nw));
 
 if (seeking) {     
  Float curPercent = val / 255 * 100;
  Float curLen = getPlayItemLength();
  if (curLen != 0) {
   int seekPos = curLen * curPercent / 100;
   setDisplayTxt("Seek to " + integerToTime(seekPos) + " / " + integerToTime(curLen) + " (" + integerToString(curPercent) + "%)");
  }
 }
}

displayTxtTimer.onTimer() {
 displayTxtTimer.stop();
 displayTxt.setText("");
}

setDisplayTxt(String txt) {
 displayTxt.setText(txt);
 displayTxtTimer.stop();
 displayTxtTimer.start();
}
