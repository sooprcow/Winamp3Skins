// Script by: David Serrano
//            SOOPRcow@deskmod.com

#include "../../../lib/std.mi"
#define SKIN_NAME "deepsmooth3"

Global Button butShuf, butRep, butFade;
Global Timer tTime;

function setHoverImage(button but, int state);

system.onScriptLoaded() {
 butShuf = getScriptGroup().getObject("shuf");
 butRep = getScriptGroup().getObject("rep");
 butFade = getScriptGroup().getObject("fade");
 
 butShuf.onActivate(butShuf.getActivated());
 butRep.onActivate(butRep.getActivated());
 butFade.onActivate(butFade.getActivated());
}

butShuf.onActivate(int state) {
 if(state) 
  butShuf.setXmlParam("hoverimage","playopt.shuf.down.hover"); 
 else 
  butShuf.setXmlParam("hoverimage","playopt.shuf.hover");
}

butRep.onActivate(int state) {
 if(state) 
  butRep.setXmlParam("hoverimage","playopt.rep.down.hover"); 
 else 
  butRep.setXmlParam("hoverimage","playopt.rep.hover");
}

butFade.onActivate(int state) {
 if(state) 
  butFade.setXmlParam("hoverimage","playopt.fade.down.hover"); 
 else 
  butFade.setXmlParam("hoverimage","playopt.fade.hover");
}

