import controlP5.*;

Textlabel stateTitle;
Textlabel stateLabel;
Textlabel frameRateLabel;
Textlabel inputLabel;
Textlabel brightnessInPercLabel;
CheckBox showOverlayCheckbox;
CheckBox offlineCheckbox;
CheckBox rotateCheckbox;
CheckBox redrawCheckbox;
CheckBox invertCheckbox;
ScrollableList overlayList;
ScrollableList backgroundList;
ScrollableList pathList;
//ScrollableList textList;

Range rangeRotationX;
Range rangeRotationZ;
Range rangeFontSize;


void constructGUI() {
  // change the original colors
  color black = color(0, 0, 0);
  color white = color(255, 255, 255);
  color gray = color(125, 125, 125);
  cp5.setAutoDraw(cp5AutoDraw);
  /*
  cp5.addSlider("sliderBrightness")
   .setRange(0, 255)
   .setPosition(15, 110)
   .setValue(255)
   .setSize(100, 8)
   .setColorValue(black)
   ;
   cp5.addSlider("rotationSpeed")
   .setRange(0, 0.05)
   .setPosition(15, 120)
   .setValue(0.01)
   .setSize(100, 8)
   .setColorValue(black)
   ;
   cp5.addSlider("theFrameRate")
   .setRange(0, 100)
   .setPosition(15, 130)
   //.setValue(theFrameRate)
   .setSize(100, 8)
   .setColorValue(black)
   ;
   cp5.addSlider("linePixelPitch")
   .setRange(0, 10)
   .setPosition(15, 140)
   //.setValue(linePixelPitch)
   .setSize(100, 8)
   .setColorValue(black)
   ;
   cp5.addSlider("sliderOptions3")
   .setRange(0, 128)
   .setPosition(15, 150)
   .setValue(128)
   .setSize(100, 8)
   .setColorValue(black)
   ;
   cp5.addSlider("sliderOptions4")
   .setRange(0, 128)
   .setPosition(15, 160)
   .setValue(128)
   .setSize(100, 8)
   .setColorValue(black)
   ;
   
   stateTitle = cp5.addTextlabel("label1")
   .setText("Overlay: ")
   .setPosition(320, 5)
   ;
   
   stateLabel = cp5.addTextlabel("label2")
   .setText("A single ControlP5 textlabel")
   .setPosition(70, 10)
   .setColorValue(0xffffff00)
   ;
   frameRateLabel = cp5.addTextlabel("label3")
   .setText("frameRate")
   .setPosition(10, 20)
   ;
   inputLabel = cp5.addTextlabel("label4")
   .setText("2D TEXTURE VIEW")
   .setPosition(10, height-140)
   ;
   
   brightnessInPercLabel = cp5.addTextlabel("label5")
   .setText("BRIGHTNESS: %")
   .setPosition(12, 100)
   ;
   
   
   
   showOverlayCheckbox = cp5.addCheckBox("showOverlayCheckbox")
   .setPosition(340, 5)
   .setSize(32, 16)
   .addItem("play", 1)
   ;
   
   offlineCheckbox = cp5.addCheckBox("offlineCheckbox")
   .setPosition(14, 40)
   .setSize(32, 8)
   .addItem("offline", 1)
   ;
   rotateCheckbox = cp5.addCheckBox("rotateCheckbox")
   .setPosition(14, 50)
   .setSize(32, 8)
   .addItem("rotate", 1)
   ;
   redrawCheckbox = cp5.addCheckBox("redrawCheckbox")
   .setPosition(14, 60)
   .setSize(32, 8)
   .addItem("redraw", 1)
   ;
   invertCheckbox = cp5.addCheckBox("invertCheckbox")
   .setPosition(14, 70)
   .setSize(32, 8)
   .addItem("invert", 1)
   ;
   */
   cp5.addButton("exportButton")
   .setValue(0)
   .setLabel("Export")
   .setPosition(400, 5)
   .setSize(40, 16)
   ;
   /*
   cp5.addButton("nextDemo")
   .setValue(0)
   .setLabel("next")
   .setPosition(50, 80)
   .setSize(32, 16)
   ;
   */
   
  rangeRotationX = cp5.addRange("rangeRotationX")
     // disable broadcasting since setRange and setRangeValues will trigger an event
     .setBroadcast(false) 
     .setPosition(450,5)
     .setSize(200,10)
     .setHandleSize(10)
     .setRange(0,360)
     .setRangeValues(0,360)
     // after the initialization we turn broadcast back on again
     .setBroadcast(true)
     .setColorForeground(color(255,40))
     .setColorBackground(color(255,40))  
     ;
   rangeRotationX = cp5.addRange("rangeRotationY")
     // disable broadcasting since setRange and setRangeValues will trigger an event
     .setBroadcast(false) 
     .setPosition(660,5)
     .setSize(200,10)
     .setHandleSize(10)
     .setRange(0,360)
     .setRangeValues(0,360)
     // after the initialization we turn broadcast back on again
     .setBroadcast(true)
     .setColorForeground(color(255,40))
     .setColorBackground(color(255,40))  
     ;
     /*
  rangeFontSize = cp5.addRange("rangeFontSize")
     // disable broadcasting since setRange and setRangeValues will trigger an event
     .setBroadcast(false) 
     .setPosition(880,5)
     .setSize(200,10)
     .setHandleSize(10)
     .setRange(0.0f,1.0f)
     .setRangeValues(0.0f,1.0f)
     // after the initialization we turn broadcast back on again
     .setBroadcast(true)
     .setColorForeground(color(255,255,0))
     .setColorBackground(color(255,40))  
     ; 
     */

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

  checkImageDropdown();
  cp5.setColorForeground(gray);
  cp5.setColorBackground(black);
  cp5.setColorActive(white);

  // settings.json werte einpassen
  // checkboxes
  float[] y = {1f};
  float[] n = {0f};

  //playCheckbox.setArrayValue((play?y:n));
  //offlineCheckbox.setArrayValue((offline?y:n));
  //rotateCheckbox.setArrayValue((rotate?y:n));
  //redrawCheckbox.setArrayValue((redraw?y:n));

  //cp5.getController("sliderBrightness").setValue(tempBrightness);
  //cp5.getController("theFrameRate").setValue(tempFrameRate);
  //cp5.getController("linePixelPitch").setValue(linePixelPitch);
}

void overlayList(int n) {
  String s = (String)cp5.get(ScrollableList.class, "overlayList").getItem(n).get("text");
  // check if this is a valid image?
  try {
    if (s.length() > 0) {
      if(s.equals("empty")) {
        showOverlay = false;
      } else {
        showOverlay = true;
        overlay = loadImage(importer.getFiles().get(n));
      }
    } else println("[#] ERROR : the image is not valid. string size is low or equal than 0");
    refresh = true;
  } catch(Exception e) {
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
}

void pathList(int n) {
  currentPath = n;
  println("currentPath = " + n);
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
  if(theControlEvent.isFrom("rangeRotationX")) {
    // min and max values are stored in an array.
    // access this array with controller().arrayValue().
    // min is at index 0, max is at index 1.
    float a = int(theControlEvent.getController().getArrayValue(0));
    float b = int(theControlEvent.getController().getArrayValue(1));
    tracers.get(currentTracer).getCurrentPath().setRotationX(a, b);
    //println("rangeRotationX ( "+ a +" / "+ b +" )on path " + currentPath + " update, done.");
  } else if(theControlEvent.isFrom("rangeRotationY")) {
    // min and max values are stored in an array.
    // access this array with controller().arrayValue().
    // min is at index 0, max is at index 1.
    float a = int(theControlEvent.getController().getArrayValue(0));
    float b = int(theControlEvent.getController().getArrayValue(1));
    tracers.get(currentTracer).getCurrentPath().setRotationY(a, b);
    //println("rangeRotationY ( "+ a +" / "+ b +" )on path " + currentPath + " update, done.");
  } else if(theControlEvent.isFrom("rangeFontSize")) {
    // min and max values are stored in an array.
    // access this array with controller().arrayValue().
    // min is at index 0, max is at index 1.
    float a = int(theControlEvent.getController().getArrayValue(0));
    float b = int(theControlEvent.getController().getArrayValue(1));
    tracers.get(currentTracer).getCurrentPath().setFontSize(a, b);
    //println("rangeRotationY ( "+ a +" / "+ b +" )on path " + currentPath + " update, done.");
  }
  
}

void exportButton(int theValue) {
  if(readyToGo) setState(EXPORT);
}
