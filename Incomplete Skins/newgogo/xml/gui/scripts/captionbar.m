// Script by: David Serrano
//            SOOPRcow@deskmod.com

#include "lib/std.mi"

Global Group grpScript;
Global Text txtCaption;

function updateCaptionBar();

system.onScriptLoaded() {
 grpScript = getScriptGroup();
 txtCaption = grpScript.getObject("caption");
 updateCaptionBar();
}

System.onSetXuiParam(String param, String value) {
 if(strlower(param)=="caption") {
  txtCaption.setText(value);
  updateCaptionBar();
 }
}

updateCaptionBar() {
 grpScript.setXmlParam("w",integerToString(txtCaption.getTextWidth()+14));
}