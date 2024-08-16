// Script by: David Serrano
//            SOOPRcow@deskmod.com

#include "../../lib/std.mi"
#include "defines.m"

Global Layer volSeekGhost,volSeekSwitch;
Global Slider volSeek,seekGhost;
Global int volSeekState;
Global Text txtLabel, txtPercent;

system.onScriptLoaded() {
	Group rightDrawerGroup = getContainer("main").getLayout("normal").getObject("group.drawer.right");
	volSeekGhost = rightDrawerGroup.getObject("volseek.ghost");
	volSeek = rightDrawerGroup.getObject("volseek");
	volSeekSwitch = rightDrawerGroup.getObject("volseek.switch");
	seekGhost = rightDrawerGroup.getObject("seek.ghost");
	txtLabel = rightDrawerGroup.getObject("volseek.label");
	txtPercent = rightDrawerGroup.getObject("volseek.percent");
	volSeekState = getPrivateInt(SKIN_NAME,"volseekstate",VOLSEEK_VOL);
	if (volSeekState == VOLSEEK_VOL) {
		volSeekGhost.setXmlParam("w", integerToString((getVolume() * 75) / 255));
		volSeek.setPosition(getVolume());
		txtPercent.setText(integerToString((getVolume() * 100) / 255) + "%");
		txtLabel.setText("volume:");
	} else {
		volSeekGhost.setXmlParam("w", integerToString((seekGhost.getPosition() * 75) / 255));
		volSeek.setPosition(seekGhost.getPosition());	
		if (getStatus() == 0) {
			txtPercent.setText("0%");
		} else {
			txtPercent.setText(integerToString((getPosition() * 100) / getPlayItemLength()) + "%");
		}
		txtLabel.setText("seek:");
	}
}

system.onStop() {
	if (volSeekState == VOLSEEK_SEEK) {
		txtPercent.setText("0%");
		volSeekGhost.setXmlParam("w", "1");
		volSeek.setPosition(1);
	}
}

system.onVolumeChanged(int newvol) {
	if (volSeekState == VOLSEEK_VOL) {
		volSeekGhost.setXmlParam("w", integerToString( (newvol * 75) / 255 ));
		volSeek.setPosition(newvol);
		txtPercent.setText(integerToString((newvol * 100) / 255) + "%");
	}
}

seekGhost.onSetPosition(int newpos) {
	if (volSeekState == VOLSEEK_SEEK) {
		volSeekGhost.setXmlParam("w", integerToString((newpos * 75) / 255));
		volSeek.setPosition(newpos);
		txtPercent.setText(integerToString((newpos * 100) / 255) + "%");
	}
}

volSeek.onSetPosition(int newpos) {
	volSeekGhost.setXmlParam("w", integerToString((newpos * 75) / 255));	
	if (volSeekState == VOLSEEK_VOL) {
		setVolume(newpos);
		txtPercent.setText(integerToString((getVolume() * 100) / 255) + "%");
	} else {
		if (getStatus() != 0) {
			txtPercent.setText(integerToString((newpos * 100) / 255) + "%");
		} else {
			txtPercent.setText("0%");
		}
	}
}

volSeek.onSetFinalPosition(int pos) {
	if (volSeekState == VOLSEEK_SEEK) {
		if (getStatus() != 0) {
			int songLength = getPlayItemLength();		
			int seekSpot = (songLength * ((pos / 255) * 100)) / 100;
			seekTo(seekSpot);
			txtPercent.setText(integerToString((pos * 100) / 255) + "%");
		} else {
			txtPercent.setText("0%");
			volSeek.setPosition(1);
		}
	}
}

volSeekSwitch.onLeftButtonUp(int x, int y) {
	if (volSeekState == VOLSEEK_VOL) {
		int seekPos;
		volSeekState = VOLSEEK_SEEK;
		if (getStatus() == 0) {
			txtPercent.setText("0%");
			seekPos = 0;
		} else {
			seekPos = getPosition();
			txtPercent.setText(integerToString((seekPos * 100) / getPlayItemLength()) + "%");
		}
		volSeekGhost.setXmlParam("w", integerToString((seekPos * 75) / 255));
		volSeek.setPosition(seekGhost.getPosition());
		txtLabel.setText("seek:");
	} else {
		volSeekState = VOLSEEK_VOL;
		txtPercent.setText(integerToString((getVolume() * 100) / 255) + "%");
		txtLabel.setText("volume:");
		volSeekGhost.setXmlParam("w", integerToString((getVolume() * 75) / 255));
		volSeek.setPosition(getVolume());
	}
	setPrivateInt(SKIN_NAME,"volseekstate",volSeekState);
}