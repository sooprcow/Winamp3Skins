#include <lib/std.mi>
#include <lib/visdata.mi>

Global VisData obj;

System.onScriptLoaded() {
  obj = new VisData;
  messageBox(integertostring(obj.getSpectrumData(1, 50)), "VSO Test", 0, "");
  delete obj;
}

