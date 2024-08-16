// Script by: David Serrano
//            SOOPRcow@deskmod.com

#include "../../../lib/std.mi"
//#include "defines.m"

Global AnimatedLayer volBarAni;

system.onScriptLoaded() {
	volBarAni = getScriptGroup().getObject("volume.ani");
	volBarAni.goToFrame((getVolume() * (volBarAni.getLength() -1)) / 255);
}

system.onVolumeChanged(int newvol) {
	volBarAni.goToFrame((newvol * (volBarAni.getLength() -1)) / 255);
}