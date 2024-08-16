// Script by: David Serrano
//            SOOPRcow@deskmod.com

#include "../../../lib/std.mi"
//#include "../../../lib/config.mi"

#define LBL_NL 0
#define LBL_PL 1
#define LBL_ML 2
#define LBL_EQ 3

Global Button buttonEq, buttonMl, buttonPl;
Global Layer buttonLabel;
Global int labelStatus; 

function showLabel(int label);
function hideLabel();

system.onScriptLoaded() {
 buttonEq = getScriptGroup().getObject("eq");
 buttonMl = getScriptGroup().getObject("ml");
 buttonPl = getScriptGroup().getObject("pl");
 buttonLabel = getScriptGroup().getObject("label");
 labelStatus = LBL_NL;
}

buttonEq.onEnterArea() {
 showLabel(LBL_EQ);
}

buttonMl.onEnterArea() {
 showLabel(LBL_ML);
}

buttonPl.onEnterArea() {
 showLabel(LBL_PL);
}

buttonEq.onLeaveArea() {
 hideLabel();
}

buttonMl.onLeaveArea() {
 hideLabel();
}

buttonPl.onLeaveArea() {
 hideLabel();
}


hideLabel() {
 if (buttonLabel.getAlpha() != 0) {
  buttonLabel.setTargetA(0);
  buttonLabel.setTargetSpeed(0.25);
  buttonLabel.gotoTarget();
 }
 labelStatus = LBL_NL;
}

showLabel(int label) {
 if (label==labelStatus) return;

 String newLBL;
 if (label==LBL_PL) newLBL="pl";
 if (label==LBL_ML) newLBL="ml";
 if (label==LBL_EQ) newLBL="eq";

 if (labelStatus==LBL_NL) {
  buttonLabel.setXmlParam("image","component.label." + newLBL);
  buttonLabel.setTargetA(255);
  buttonLabel.setTargetSpeed(0.25);
  buttonLabel.gotoTarget();
 } else {
  buttonLabel.setXmlParam("image","component.label." + newLBL);
 }
 labelStatus = label;
}


