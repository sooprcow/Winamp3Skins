// Script by: David Serrano
//            SOOPRcow@deskmod.com

#include "../../../lib/std.mi"
//#include "../../../lib/config.mi"

Global Layout layMain, layMainShade1, layMainShade2;
Global Layer volBrick, seekBrick, dmLogo, dmLogoShade, dmLogoShade2;
Global Slider seekSlide;
Global Text time1, time2, time3, time4, time5;
Global Text stime1, stime2, stime3, stime4, stime5;
Global Text info1, info2, info3, info4, info5;
Global Text sinfo1, sinfo2, sinfo3, sinfo4, sinfo5;
Global Timer volTimer;

function updateVolumeBar(int vol);
function updateSeekBar(int val);
function getObjects();

system.onScriptLoaded() {
 getObjects();

 updateVolumeBar(getVolume());
 volTimer = new Timer;
 volTimer.setDelay(1000);
}

time1.onTextChanged(string newtxt) {
 time2.setText(newtxt);
 time3.setText(newtxt);
 time4.setText(newtxt);
 time5.setText(newtxt);
}

stime1.onTextChanged(string newtxt) {
 stime2.setText(newtxt);
 stime3.setText(newtxt);
 stime4.setText(newtxt);
 stime5.setText(newtxt);
}

info1.onTextChanged(string newtxt) {
 info2.setText(newtxt);
 info3.setText(newtxt);
 info4.setText(newtxt);
 info5.setText(newtxt);
}

sinfo1.onTextChanged(string newtxt) {
 sinfo2.setText(newtxt);
 sinfo3.setText(newtxt);
 sinfo4.setText(newtxt);
 sinfo5.setText(newtxt);
}

dmLogo.onLeftButtonDblClk(int x, int y) {
 navigateUrl("http://www.deskmod.com");
}

dmLogoShade.onLeftButtonDblClk(int x, int y) {
 navigateUrl("http://www.deskmod.com");
}

dmLogoShade2.onLeftButtonDblClk(int x, int y) {
 navigateUrl("http://www.deskmod.com");
}

volTimer.onTimer() {
 info1.setText("");
 sinfo1.setText("");
 volTimer.stop();
}

system.onStop() {
 updateSeekBar(0);
}

seekSlide.onSetPosition(int newpos) {
 updateSeekBar(newpos);
}

seekSlide.onPostedPosition(int newpos) {
 updateSeekBar(newpos);
}

seekSlide.onSetFinalPosition(int pos) {
 updateSeekBar(newpos);
}

system.onVolumeChanged(int vol) {
 updateVolumeBar(vol);
 info1.setText("Volume: " + integerToString(vol / 2.55) + "%");
 sinfo1.setText("Volume: " + integerToString(vol / 2.55) + "%");
 volTimer.stop();
 volTimer.start();
}

updateVolumeBar(int vol) {
 int nw = ((vol / 2.55) * 0.72);
 if (nw % 4) nw = nw - (nw % 4);
 if (vol == 255) nw=72;
 volBrick.setXmlParam("w",integerToString(nw));
}

updateSeekBar(int val) {
 int nw = ((val / 2.55) * 0.78);
 if (nw % 7) nw = nw - (nw % 7);
 if (val == 255) nw=78;
 seekBrick.setXmlParam("w",integerToString(nw));
}

getObjects() {
 layMain = getContainer("main").getLayout("normal");
 layMainShade1 = getContainer("main").getLayout("shade1");
 layMainShade2 = getContainer("main").getLayout("shade2");

 Group visGroup = layMain.getObject("group.vis");
 Group volGroup = layMain.getObject("group.volume");
 Group infoGroup = layMain.getObject("group.info");
 Group titleGroup = layMain.getObject("group.titlebar");
 Group seekGroup = layMain.getObject("group.seek");

 Group shadeTitleGroup = layMainShade1.getObject("group.shade1.titlebar");
 Group shadeTimeGroup = layMainShade1.getObject("group.shade.timer");
 Group shadeInfoGroup = layMainShade1.getObject("group.shade.info");
 Group shadeTitleGroup2 = layMainShade2.getObject("group.shade2.titlebar");
 
 volBrick = volGroup.getObject("brick");
 seekBrick = seekGroup.getObject("brick");
 seekSlide = seekGroup.getObject("seek");
 dmLogo = titleGroup.getObject("logo");
 dmLogoShade = shadeTitleGroup.getObject("logo");
 dmLogoShade2 = shadeTitleGroup2.getObject("logo");

 time1 = visGroup.getObject("time1"); time2 = visGroup.getObject("time2");
 time3 = visGroup.getObject("time3"); time4 = visGroup.getObject("time4");
 time5 = visGroup.getObject("time5");

 stime1 = shadeTimeGroup.getObject("time1"); stime2 = shadeTimeGroup.getObject("time2");
 stime3 = shadeTimeGroup.getObject("time3"); stime4 = shadeTimeGroup.getObject("time4");
 stime5 = shadeTimeGroup.getObject("time5");

 info1 = infoGroup.getObject("info1"); info2 = infoGroup.getObject("info2");
 info3 = infoGroup.getObject("info3"); info4 = infoGroup.getObject("info4");
 info5 = infoGroup.getObject("info5");

 sinfo1 = shadeinfoGroup.getObject("info1"); sinfo2 = shadeinfoGroup.getObject("info2");
 sinfo3 = shadeinfoGroup.getObject("info3"); sinfo4 = shadeinfoGroup.getObject("info4");
 sinfo5 = shadeinfoGroup.getObject("info5");
}