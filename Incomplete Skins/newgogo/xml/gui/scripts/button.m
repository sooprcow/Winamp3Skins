// Script by: David Serrano
//            SOOPRcow@deskmod.com

#include "../../../../../lib/std.mi"
#define MOUSE_UP 0;
#define MOUSE_DOWN 1;

Global Group grpScript;
Global Button objButton;
Global GuiObject downRect;
Global Int curMouseState;

function setButtonState(int state);

system.onScriptLoaded() {
 grpScript = getScriptGroup();
 objButton = grpScript.getObject("objbutton");
 downRect = grpScript.getObject("downrect");
 curMouseState = MOUSE_UP;
}

System.onSetXuiParam(String param, String value) {
 if(strlower(param)=="disabled") {
  if(stringToInteger(value)) {
   grpScript.getObject("disabled").show();
   objButton.setEnabled(false);
  } else {
   grpScript.getObject("disabled").hide();
   objButton.setEnabled(true);
  }
 }
 if(strlower(param)=="nogrid") {
  if(stringToInteger(value)) {
   grpScript.getObject("grid").hide();
  } else {
   grpScript.getObject("grid").show();
  }
 }
 if(strlower(param)=="text") objButton.setXmlParam("y","-1");

objButton.onLeftButtonDown(int x, int y) {
 if(objButton.getEnabled()) {
  setButtonState(1);
  curMouseState = MOUSE_DOWN;
 }
}

objButton.onLeftButtonUp(int x, int y) {
 if(objButton.getEnabled()) {
  setButtonState(0);
  curMouseState = MOUSE_UP;
 }
}

objButton.onMouseMove(int x, int y) {
 if(curMouseState) {
  setButtonState(objButton.isMouseOver(x, y));
 }
}

setButtonState(int state) {
 if(state) {
  downRect.show();
  objButton.setXmlParam("x","-1");
 } else {
  downRect.hide();
  objButton.setXmlParam("x","0");
 }
}
