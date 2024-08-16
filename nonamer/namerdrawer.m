// Script by: David Serrano
//            SOOPRcow@deskmod.com

#include "../../lib/std.mi"
#include "defines.m"

Global Group leftDrawerGroup, rightDrawerGroup;
Global Layer leftDrawer, rightDrawer, forceLeftDrawer, forceRightDrawer;
Global int leftDrawerState, rightDrawerState, forceLeftDrawerState, forceRightDrawerState;
Global Timer leftDrawerCheck, rightDrawerCheck;

function _forceDrawers(int open, float speed, int drawer);

system.onScriptLoaded() {
	// Setup Left Drawer
	leftDrawerGroup = getContainer("main").getLayout("normal").getObject("group.drawer.left");
	leftDrawer = leftDrawerGroup.getObject("left.drawer.bg");
	leftDrawerState = false;
	leftDrawerCheck = new Timer; leftDrawerCheck.setDelay(1000);
	// Setup Right Drawer
	rightDrawerGroup = getContainer("main").getLayout("normal").getObject("group.drawer.right");
	rightDrawer = rightDrawerGroup.getObject("right.drawer.bg");
	rightDrawerState = false;
	rightDrawerCheck = new Timer; rightDrawerCheck.setDelay(1000);
	// Setup Force Drawer
	Group leftArea = getContainer("main").getLayout("normal").getObject("group.left.panel");
	forceLeftDrawer = leftArea.getObject("forceleftdrawer");
	forceLeftDrawerState = getPrivateInt(SKIN_NAME,"forceleftdrawer",0);
	Group rightArea = getContainer("main").getLayout("normal").getObject("group.right.panel");
	forceRightDrawer = rightArea.getObject("forcerightdrawer");
	forceRightDrawerState = getPrivateInt(SKIN_NAME,"forcerightdrawer",0);
	if (forceLeftDrawerState == 1) { _forceDrawers(1,0,DRAWER_LEFT); }
	if (forceRightDrawerState == 1) { _forceDrawers(1,0,DRAWER_RIGHT); }
}


leftDrawerGroup.onEnterArea() {
	if (leftDrawerGroup.isGoingToTarget() == false) {
		if ((leftDrawerState == false) && (forceLeftDrawerState == false)) {
			leftDrawerGroup.setTargetX(11);
			leftDrawerGroup.setTargetY(36);
			leftDrawerGroup.setTargetSpeed(0.65);
			leftDrawerGroup.gotoTarget();
			leftDrawerState = true;
			leftDrawerCheck.start();
		}
	}
}

leftDrawerCheck.onTimer() {
	if (leftDrawerGroup.isGoingToTarget() == false) {
		if ((leftDrawerState == true) && (forceLeftDrawerState == false)) {
			int screenLayerLeft  = leftDrawer.clientToScreenX(leftDrawer.getLeft());
			int screenLayerTop   = leftDrawer.clientToScreenY(leftDrawer.getTop());
			int screenLayerBot   = leftDrawer.clientToScreenY(screenLayerTop + leftDrawer.getHeight());
			int screenLayerRight = leftDrawer.clientToScreenX(screenLayerLeft + leftDrawer.getWidth());
			int mx = getMousePosX(); int my = getMousePosY();
			if ( (mx < screenLayerLeft) || (mx > screenLayerRight) || (my < screenLayerTop) || (my > screenLayerBot)) {
				leftDrawerCheck.stop();
				leftDrawerGroup.setTargetX(11);
				leftDrawerGroup.setTargetY(21);
				leftDrawerGroup.setTargetSpeed(0.65);
				leftDrawerGroup.gotoTarget();
				leftDrawerState = false;
			}
		} else {
			leftDrawerCheck.stop();
		}
	}
}

rightDrawerGroup.onEnterArea() {
	if (rightDrawerGroup.isGoingToTarget() == false) {
		if ((rightDrawerState == false) && (forceRightDrawerState == false)) {
			rightDrawerGroup.setTargetX(108);
			rightDrawerGroup.setTargetY(36);
			rightDrawerGroup.setTargetSpeed(0.65);
			rightDrawerGroup.gotoTarget();
			rightDrawerState = true;
			rightDrawerCheck.start();
		}
	}
}

rightDrawerCheck.onTimer() {
	if (rightDrawerGroup.isGoingToTarget() == false) {
		if ( (rightDrawerState == true) && (forceRightDrawerState == false) ) {
			int screenLayerLeft  = rightDrawer.clientToScreenX(rightDrawer.getLeft());
			int screenLayerTop   = rightDrawer.clientToScreenY(rightDrawer.getTop());
			int screenLayerBot   = rightDrawer.clientToScreenY(screenLayerTop + rightDrawer.getHeight());
			int screenLayerRight = rightDrawer.clientToScreenX(screenLayerLeft + rightDrawer.getWidth());
			int mx = getMousePosX(); int my = getMousePosY();
			if ( (mx < screenLayerLeft) || (mx > screenLayerRight) || (my < screenLayerTop) || (my > screenLayerBot)) {
				rightDrawerCheck.stop();
				rightDrawerGroup.setTargetX(108);
				rightDrawerGroup.setTargetY(21);
				rightDrawerGroup.setTargetSpeed(0.65);
				rightDrawerGroup.gotoTarget();
				rightDrawerState = false;
			}
		} else {
			rightDrawerCheck.stop();
		}
	}
}

forceLeftDrawer.onLeftButtonUp(int x, int y) {
	if (forceLeftDrawerState == 0) {
		_forceDrawers(1,0.65,DRAWER_LEFT);
		setPrivateInt(SKIN_NAME,"forceleftdrawer",1); forceLeftDrawerState = true;
	} else {
		_forceDrawers(0,0.65,DRAWER_LEFT);
		setPrivateInt(SKIN_NAME,"forceleftdrawer",0); forceLeftDrawerState = false;
	}
}

forceRightDrawer.onLeftButtonUp(int x, int y) {
	if (forceRightDrawerState == 0) {
		_forceDrawers(1,0.65,DRAWER_RIGHT);
		setPrivateInt(SKIN_NAME,"forcerightdrawer",1); forceRightDrawerState = true;
	} else {
		_forceDrawers(0,0.65,DRAWER_RIGHT);
		setPrivateInt(SKIN_NAME,"forcerightdrawer",0); forceRightDrawerState = false;
	}
}

_forceDrawers(int open, float speed, int drawer) {
	if (open == 1) {
		if (drawer == DRAWER_LEFT) {
			leftDrawerGroup.setTargetX(11);
			leftDrawerGroup.setTargetY(36);
			leftDrawerGroup.setTargetSpeed(speed);
			leftDrawerGroup.gotoTarget();
			leftDrawerState = true;
			forceLeftDrawerState = true;
		} else {
			rightDrawerGroup.setTargetX(108);
			rightDrawerGroup.setTargetY(36);
			rightDrawerGroup.setTargetSpeed(speed);
			rightDrawerGroup.gotoTarget();
			rightDrawerState = true;
			forceRightDrawerState = true;
		}
	} else {
		if (drawer == DRAWER_LEFT) {
			leftDrawerGroup.setTargetX(11);
			leftDrawerGroup.setTargetY(21);
			leftDrawerGroup.setTargetSpeed(speed);
			leftDrawerGroup.gotoTarget();
			leftDrawerState = false;
			forceRightDrawerState = false;
		} else {
			rightDrawerGroup.setTargetX(108);
			rightDrawerGroup.setTargetY(21);
			rightDrawerGroup.setTargetSpeed(speed);
			rightDrawerGroup.gotoTarget();
			rightDrawerState = false;
			forceRightDrawerState = false;
		}
	}	
}