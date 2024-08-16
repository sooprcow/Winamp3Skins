// Script by: David Serrano
//            SOOPRcow@deskmod.com

#include "../../../../../lib/std.mi"
#define NULL_ID "*"

Global Container lCont;
Global Button bShade;

Global GuiObject bMin, bState, bClose;
Global String strForceShade;

function changeLayout();

system.onScriptLoaded() {
 Group sGroup = getScriptGroup();
 Layout curLay = sGroup.getParentLayout();
 lCont = curLay.getContainer();
 Group gShade = sGroup.getObject("state");
 bShade = gShade.getObject("objbutton");

 bMin = sGroup.getObject("min");
 bState = sGroup.getObject("state");
 bClose = sGroup.getObject("close");
 strForceShade = NULL_ID;
}

System.onSetXuiParam(String param, String value) {
 if(strlower(param)=="nomin") {
  if(value=="1") {
   bMin.setXmlParam("disabled","1");
  } else {
   bMin.setXmlParam("disabled","0");
  }
 } else if (strlower(param)=="nostate") {
  if(value=="1") {
   bState.setXmlParam("disabled","1");
  } else {
   bState.setXmlParam("disabled","0");
  }
 } else if (strlower(param)=="noclose") {
  if(value=="1") {
   bClose.setXmlParam("disabled","1");
  } else {
   bClose.setXmlParam("disabled","0");
  }
 } else if (strlower(param)=="forceshade") {
  strForceShade = value;
 }
 if(strlower(param)=="dblclickstate") {
  getScriptGroup().getObject("mousetrap").setXmlParam("dblclickaction","SWITCH;"+value);
 }
 if(strlower(param)=="notitle") {
  if(stringToInteger(value)) {
   getScriptGroup().getObject("caption.bar").hide();
  } else {
   getScriptGroup().getObject("caption.bar").show();
  }
 }
}


bShade.onLeftButtonUp(int x, int y) {
 changeLayout();
}

changeLayout() {
 if(strForceShade!=NULL_ID) {
  lCont.switchToLayout(strForceShade);
  return;
 }
 PopupMenu tMenu = new PopupMenu;
 Layout lTemp;
 String sTitle;
 
 int t = lCont.getNumLayouts();
 
 if(t > 1) {
  for(int i=0; i<t; i++) {
   lTemp = lCont.enumLayout(i);
   sTitle = lTemp.getXmlParam("name");
   if(!sTitle) lTemp.getXmlParam("id");
   tMenu.addCommand(sTitle, i+1, lTemp.isVisible(), false);
  }
 
  int val = tMenu.popAtMouse();
  if(val > 0) lCont.switchToLayout(lCont.enumLayout(val-1).getXmlParam("id"));
 }
 delete tMenu;
}