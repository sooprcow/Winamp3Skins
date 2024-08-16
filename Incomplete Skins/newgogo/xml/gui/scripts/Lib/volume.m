//----------------------------------------------------------------------------------------
// volume.m                                               by Luc Lamothe, lucas@blorp.com
//                                                                last updated: 15-oct-01
//----------------------------------------------------------------------------------------
// Use like this :
// #define VOLUME_VAR MyVar
// #include "volume.m"
//
// _MyVarInit(Layer Volume, Layer VolumeFull, Map VolumeMap);

Global Int _##VOLUME_VAR##Clicked;
Global Map _##VOLUME_VAR##VolumeMap;
Global Layer _##VOLUME_VAR##Surface;
Global Layer _##VOLUME_VAR##SurfaceFull;

Function _##VOLUME_VAR##Init(Layer Volume, Layer VolumeFull, Map VolumeMap);
Function _##VOLUME_VAR##Update(int newpos);
Function _##VOLUME_VAR##UpdateXY(int x, int y);


_##VOLUME_VAR##Init(Layer Volume, Layer VolumeFull, Map VolumeMap)
{
  _##VOLUME_VAR##Clicked = 0;
  _##VOLUME_VAR##Surface = Volume;
  _##VOLUME_VAR##SurfaceFull = VolumeFull;
  _##VOLUME_VAR##VolumeMap = VolumeMap;

  int n = System.getVolume();
  _##VOLUME_VAR##Update(n);
}

_##VOLUME_VAR##Update(int newpos) {
  int p = 0;
  p = newpos;

  if (newpos > 0) p = newpos / 1 * 255;

  Region r = new Region;
  r.loadFromMap(_##VOLUME_VAR##VolumeMap, newpos, 1);
  r.offset(-_##VOLUME_VAR##SurfaceFull.getLeft(), -_##VOLUME_VAR##SurfaceFull.getTop());
  _##VOLUME_VAR##SurfaceFull.setRegion(r);
  delete r;
}

_##VOLUME_VAR##Surface.onLeftButtonUp(int x, int y) {
  _##VOLUME_VAR##Clicked = 0;
}

_##VOLUME_VAR##Surface.onLeftButtonDown(int x, int y) {
  _##VOLUME_VAR##Clicked = 1;
  _##VOLUME_VAR##Surface.onMouseMove(x, y);
}

_##VOLUME_VAR##Surface.onMouseMove(int x, int y) {
  int nx = x - _##VOLUME_VAR##SurfaceFull.getLeft();
  int ny = y - _##VOLUME_VAR##SurfaceFull.getTop();
  Map m = new Map;
  m.loadMap(_##VOLUME_VAR##SurfaceFull.getXmlParam("image"));
  if ((_##VOLUME_VAR##Clicked) && m.inRegion(nx,ny)) {
    _##VOLUME_VAR##UpdateXY(x, y);
  }
 delete m;
}

_##VOLUME_VAR##UpdateXY(int x, int y) {
  if ((x > 0) && (y > 0) && (x < _##VOLUME_VAR##VolumeMap.getWidth()) && (y < _##VOLUME_VAR##VolumeMap.getHeight())) {
    int n = _##VOLUME_VAR##VolumeMap.getValue(x, y);
    Region r = new Region;
    r.loadFromMap(_##VOLUME_VAR##VolumeMap, n, 1);
    r.offset(-_##VOLUME_VAR##SurfaceFull.getLeft(), -_##VOLUME_VAR##SurfaceFull.getTop());
    _##VOLUME_VAR##SurfaceFull.setRegion(r);
    delete r;
    System.setVolume(n);
  }
}

#ifndef _##VOLUME_VAR##NOSYSTEMHOOK
System.onVolumeChanged(int newvol) {
  _##VOLUME_VAR##Update(newvol);
}
#endif
