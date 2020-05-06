import controlP5.*;

Textlabel stateTitle;

CheckBox rotModeX;
CheckBox rotModeY;
CheckBox globalTextsCheckbox;
CheckBox globalFontFaceCheckbox;
CheckBox globalFontSizeCheckbox;

ScrollableList overlayList;
ScrollableList backgroundList;
ScrollableList pathList;
ScrollableList textList;
ScrollableList fontFaceList;
ScrollableList fontSizeList;

Range rangeRotationX;
Range rangeRotationZ;
Range rangeFontSize;


void constructGUI() {
  // change the original colors
  color black = color(0, 0, 0);
  color white = color(255, 255, 255);
  color gray = color(125, 125, 125);
  cp5.setAutoDraw(cp5AutoDraw);

  // SCROLLABLE LISTS

  overlayList = cp5.addScrollableList("overlayList")
    .setPosition(5, 5)
    .setSize(100, 400)
    .setBarHeight(20)
    .setItemHeight(20)
    .setType(ControlP5.LIST)
    .setLabel("Overlays")
    ;
  backgroundList = cp5.addScrollableList("backgroundList")
    .setPosition(109, 5)
    .setSize(100, 400)
    .setBarHeight(20)
    .setItemHeight(20)
    .setType(ControlP5.LIST)
    .setLabel("Backgrounds")
    ;
  pathList = cp5.addScrollableList("pathList")
    .setPosition(213, 5)
    .setSize(100, 400)
    .setBarHeight(20)
    .setItemHeight(20)
    .setType(ControlP5.LIST)
    .setLabel("Paths")
    ;
  textList = cp5.addScrollableList("textList")
    .setPosition(317, 5)
    .setSize(100, 400)
    .setBarHeight(20)
    .setItemHeight(20)
    .setType(ControlP5.LIST)
    .setLabel("Texts")
    ;
  fontFaceList = cp5.addScrollableList("fontFaceList")
    .setPosition(421, 5)
    .setSize(140, 400)
    .setBarHeight(20)
    .setItemHeight(20)
    .setType(ControlP5.LIST)
    .setLabel("Font Faces")
    ;
  fontSizeList = cp5.addScrollableList("fontSizeList")
    .setPosition(565, 5)
    .setSize(100, 400)
    .setBarHeight(20)
    .setItemHeight(20)
    .setType(ControlP5.LIST)
    .setLabel("Font Sizes")
    ;

  // BUTTONS
  cp5.addButton("activePathButton")
    .setValue(0)
    .setLabel("Show Active Path")
    .setPosition(800, 2)
    .setSize(80, 26)
    ;
  cp5.addButton("exportButton")
    .setValue(0)
    .setLabel("Export")
    .setPosition(width-60, 2)
    .setSize(40, 26)
    ;

  // SLIDER
  cp5.addSlider("sliderCutoff")
    .setRange(0f, 1f)
    .setPosition(900, 2)
    .setValue(1f)
    .setSize(100, 20)
    .setColorValue(black)
    .setLabel("text cutoff")
    ;
  cp5.addSlider("sliderStartIndex")
    .setRange(0f, 1f)
    .setPosition(900, 22)
    .setValue(0f)
    .setSize(100, 20)
    .setColorValue(black)
    .setLabel("index offset")
    ;
  // LABELS

  /*
   
   stateTitle = cp5.addTextlabel("label1")
   .setText("Overlay: ")
   .setPosition(530, 5)
   ;
   */

  // CHECKBOXES
  rotModeX = cp5.addCheckBox("rotModeXCheckbox")
    .setPosition(1250, 30)
    .setSize(16, 16)
    .addItem("rotate mode X", 1)
    ;
  rotModeY = cp5.addCheckBox("rotModeYCheckbox")
    .setPosition(1400, 30)
    .setSize(16, 16)
    .addItem("rotate mode Y", 1)
    ;

  globalTextsCheckbox = cp5.addCheckBox("globalTextsCheckbox")
    .setPosition(800, 30)
    .setSize(16, 16)
    .addItem("global text file", 1)
    ;
  globalFontFaceCheckbox = cp5.addCheckBox("globalFontFaceCheckbox")
    .setPosition(670, 12)
    .setSize(16, 16)
    .addItem("global font face", 1)
    ;
  globalFontSizeCheckbox = cp5.addCheckBox("globalFontSizeCheckbox")
    .setPosition(670, 30)
    .setSize(16, 16)
    .addItem("global font size", 1)
    ;



  // RANGE SLIDERS

  rangeRotationX = cp5.addRange("rangeRotationX")
    // disable broadcasting since setRange and setRangeValues will trigger an event
    .setBroadcast(false) 
    .setPosition(1250, 2)
    .setSize(200, 10)
    .setHandleSize(10)
    .setRange(0, 360)
    .setRangeValues(0, 360)
    // after the initialization we turn broadcast back on again
    .setBroadcast(true)
    .setColorForeground(color(255, 40))
    .setColorBackground(color(255, 40))
    .setLabel("rotation X")
    ;
  rangeRotationX = cp5.addRange("rangeRotationY")
    // disable broadcasting since setRange and setRangeValues will trigger an event
    .setBroadcast(false) 
    .setPosition(1400, 2)
    .setSize(200, 10)
    .setHandleSize(10)
    .setRange(0, 360)
    .setRangeValues(0, 360)
    // after the initialization we turn broadcast back on again
    .setBroadcast(true)
    .setColorForeground(color(255, 40))
    .setColorBackground(color(255, 40))
    .setLabel("rotation Y")
    ;



  checkImageDropdown();
  cp5.setColorForeground(gray);
  cp5.setColorBackground(black);
  cp5.setColorActive(white);

  // settings.json werte einpassen
  // checkboxes


  //rotModeX.setArrayValue((play?y:n));
  //offlineCheckbox.setArrayValue((offline?y:n));
  //rotateCheckbox.setArrayValue((rotate?y:n));
  //redrawCheckbox.setArrayValue((redraw?y:n));

  //cp5.getController("sliderBrightness").setValue(tempBrightness);
  //cp5.getController("theFrameRate").setValue(tempFrameRate);
  //cp5.getController("linePixelPitch").setValue(linePixelPitch);
}

// SCROLLABLE LISTS
void overlayList(int n) {
  String s = (String)cp5.get(ScrollableList.class, "overlayList").getItem(n).get("text");
  // check if this is a valid image?
  try {
    if (s.length() > 0) {
      if (s.equals("empty")) {
        showOverlay = false;
      } else {
        showOverlay = true;
        overlay = loadImage(importer.getFiles().get(n));
      }
      cp5.get(ScrollableList.class, "overlayList").close();
    } else println("[#] ERROR : the image is not valid. string size is low or equal than 0");
    refresh = true;
  } 
  catch(Exception e) {
  }
  //println("currentTracer = " + n);
}

void backgroundList(int n) {
  String s = (String)cp5.get(ScrollableList.class, "backgroundList").getItem(n).get("text");
  // check if this is a valid image?
  cleanCurrentPathList(currentTracer);
  currentTracer = n;
  initCurrentPathList(currentTracer);
  refresh = true;
  cp5.get(ScrollableList.class, "backgroundList").close();
}

void pathList(int n) {
  try {
    currentPath = n;
    String s = (String)cp5.get(ScrollableList.class, "pathList").getItem(n).get("text");
    cp5.get(ScrollableList.class, "pathList").close();
  
    Path p = tracers.get(currentTracer).getCurrentPath();
    if (p != null) {
      int cluster = p.getCluster();
      s = (String)cp5.get(ScrollableList.class, "textList").getItem(cluster).get("text");
      cp5.get(ScrollableList.class, "textList").setLabel(s);
      cp5.get(ScrollableList.class, "textList").setValue(cluster);
      cp5.get(ScrollableList.class, "textList").close();
  
      float cutoff = p.getCutoff();
      cp5.getController("sliderCutoff").setValue(cutoff);
      
      float indexOffset = p.getIndexOffset();
      cp5.getController("sliderStartIndex").setValue(indexOffset);
  
      boolean bX = p.getRotModeX();
      boolean bY = p.getRotModeY();
      float[] yes = {1f};
      float[] no = {0f};
      rotModeX.setArrayValue((bX?yes:no));
      rotModeY.setArrayValue((bY?yes:no));
      
      int fontFace = p.getFontFace();
      s = (String)cp5.get(ScrollableList.class, "fontFaceList").getItem(fontFace).get("text");
      cp5.get(ScrollableList.class, "fontFaceList").setLabel(s);
      cp5.get(ScrollableList.class, "fontFaceList").setValue(fontFace);
      cp5.get(ScrollableList.class, "fontFaceList").close();
      
      int fontSize = p.getFontSize();
      s = (String)cp5.get(ScrollableList.class, "fontSizeList").getItem(fontSize).get("text");
      //cp5.get(ScrollableList.class, "fontSizeList").setLabel(s);
      cp5.get(ScrollableList.class, "fontSizeList").setValue(fontSize);
      cp5.get(ScrollableList.class, "fontSizeList").close();
      
    }
  } catch(Exception e) {}
}

void textList(int n) {
  String s = (String)cp5.get(ScrollableList.class, "textList").getItem(n).get("text");
  //clusters[n];
  if (s.length() > 0) {
    if (!globalTexts) {
      tracers.get(currentTracer).getCurrentPath().setClusterAndInit(n);
    } else {

      Tracer t = tracers.get(currentTracer);
      if (t.getPathCount() > 0) {
        for (int i = 0; i<t.getPathCount(); i++) {
          Path p = t.getThisPath(i);
          p.setClusterAndInit(n);
        }
      }
      
    }
  }
}

void fontFaceList(int n) {
  String s = (String)cp5.get(ScrollableList.class, "fontFaceList").getItem(n).get("text");
  //clusters[n];
  if (s.length() > 0) {
    if(!globalFontFace) {
      tracers.get(currentTracer).getCurrentPath().setFontFace(n);
    } else {
      try {
        Tracer t = tracers.get(currentTracer);
        if (t.getPathCount() > 0) {
          for (int i = 0; i<t.getPathCount(); i++) {
            Path p = t.getThisPath(i);
            p.setFontFace(n);
          }
        }
      } catch(Exception e) {
      }
    }
  }
  
}
void fontSizeList(int n) {
  String s = (String)cp5.get(ScrollableList.class, "fontSizeList").getItem(n).get("text");
  int k = Integer.parseInt(s);

  try {
  //clusters[n];
    if (k > 0) {
      if(!globalFontSize) {
        tracers.get(currentTracer).getCurrentPath().setFontSize(k);
      } else {
        Tracer t = tracers.get(currentTracer);
        if (t.getPathCount() > 0) {
          for (int i = 0; i<t.getPathCount(); i++) {
            Path p = t.getThisPath(i);
            p.setFontSize(k);
          }
        }
      }
    }
  } catch(Exception e) {}
}

void checkImageDropdown() {
  /*
  if(overlayList != null) {
   if(state == 11) cp5.get(ScrollableList.class, "overlayList").show();
   else cp5.get(ScrollableList.class, "overlayList").hide();
   }
   */
}

void controlEvent(ControlEvent theControlEvent) {
  if (theControlEvent.isFrom("rangeRotationX")) {
    // min and max values are stored in an array.
    // access this array with controller().arrayValue().
    // min is at index 0, max is at index 1.
    float a = int(theControlEvent.getController().getArrayValue(0));
    float b = int(theControlEvent.getController().getArrayValue(1));
    tracers.get(currentTracer).getCurrentPath().setRotationX(a, b);
    //println("rangeRotationX ( "+ a +" / "+ b +" )on path " + currentPath + " update, done.");
  } else if (theControlEvent.isFrom("rangeRotationY")) {
    // min and max values are stored in an array.
    // access this array with controller().arrayValue().
    // min is at index 0, max is at index 1.
    float a = int(theControlEvent.getController().getArrayValue(0));
    float b = int(theControlEvent.getController().getArrayValue(1));
    tracers.get(currentTracer).getCurrentPath().setRotationY(a, b);
    //println("rangeRotationY ( "+ a +" / "+ b +" )on path " + currentPath + " update, done.");
  } else if (theControlEvent.isFrom("rangeFontSize")) {
    // min and max values are stored in an array.
    // access this array with controller().arrayValue().
    // min is at index 0, max is at index 1.
    float a = int(theControlEvent.getController().getArrayValue(0));
    float b = int(theControlEvent.getController().getArrayValue(1));
    tracers.get(currentTracer).getCurrentPath().setFontSizes(a, b);
    //println("rangeRotationY ( "+ a +" / "+ b +" )on path " + currentPath + " update, done.");
  }
}


// BUTTONS
void exportButton(int theValue) {
  if (readyToGo) setState(EXPORT);
}

void activePathButton(int theValue) {
  if (readyToGo) showActivePath = !showActivePath;
}


// SLIDERS
void sliderCutoff(float theVal) {
  if (readyToGo) {
    if (tracers.get(currentTracer).getCurrentPath() != null) {
      tracers.get(currentTracer).getCurrentPath().setCutoff(theVal);
    }
  }
}

void sliderStartIndex(float theVal) {
  if (readyToGo) {
    if (tracers.get(currentTracer).getCurrentPath() != null) {
      Path p = tracers.get(currentTracer).getCurrentPath();
      p.setIndexOffset(theVal);
      p.initText();
    }
  }
}


// CHECKBOXES
void rotModeXCheckbox(float[] a) {
  boolean b = false;
  if (a[0] == 1f) b = true;
  else b = false;

  if (readyToGo) {
    if (tracers.get(currentTracer).getCurrentPath() != null) {
      tracers.get(currentTracer).getCurrentPath().setRotModeX(b);
    }
  }
}

void rotModeYCheckbox(float[] a) {
  boolean b = false;
  if (a[0] == 1f) b = true;
  else b = false;

  if (readyToGo) {
    if (tracers.get(currentTracer).getCurrentPath() != null) {
      tracers.get(currentTracer).getCurrentPath().setRotModeY(b);
    }
  }
}

void globalTextsCheckbox(float[] a) {
  if (readyToGo) {
    boolean b = false;
    if (a[0] == 1f) globalTexts = true;
    else globalTexts = false;
  }
}

void globalFontFaceCheckbox(float[] a) {
  if (readyToGo) {
    boolean b = false;
    if (a[0] == 1f) globalFontFace = true;
    else globalFontFace = false;
  }
}

void globalFontSizeCheckbox(float[] a) {
  if (readyToGo) {
    boolean b = false;
    if (a[0] == 1f) globalFontSize = true;
    else globalFontSize = false;
  }
}
