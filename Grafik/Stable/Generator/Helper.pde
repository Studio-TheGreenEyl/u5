import processing.pdf.*;

int setWidth = 36614;
int setHeight = 10630;
int[] segments = {16000, 16000, 4614};
int segmentWidth = 16000;
int restWidth = 4614;
float scaleFactor = 14.7637096774;

ControlP5 cp5; 
ArrayList<Tracer> tracers = new ArrayList<Tracer>();
String[][] clusters;
Importer importer; // overlays, backgrounds, texts

PGraphics[] buffer = new PGraphics[3];
PGraphics preview;
PGraphics active;
PImage overlay;

// boolean section
boolean ignoringStyles = true;
boolean showOverlay = true;
boolean cp5AutoDraw = true;
boolean refresh = true;
boolean record = false;
boolean readyToGo = false;
boolean fullResolution = false;
boolean showActivePath = false;
float partRes = 0.5; // half res 

int menuHeight = 30;

int currentTracer = 0;
int currentPath = 0;
int currentBuffer = 0;
int polygonizerLength = 20;

int exportFrame = 0;

// fonts
PFont myFont[] = new PFont[9];
PFont myFontUpscaled[] = new PFont[9];
String fontname = "Theinhardt";
String suffix = "Ita";
int fontSize = 14;
int fontScaling = 4;
float fontScaling2 = 15.44;
float kerning = 1.0;

int state = SETUP;

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      setState(EXPORT);
      //current++;
      //if(current >= tracer.getPathCount()) current = tracer.getPathCount()-1;
    } else if (keyCode == DOWN) {
      exit();
      //current--;
      //if(current <= 0) current = 0;
    }
    //println("show path " + (current+1) + " / " + tracer.getPathCount());
  } else {
    if (key == 'e' || key == 'E') {
      setState(EXPORT);
      
    } else if (key == 'r' || key == 'R') {
      record = true;
    }
  }
}

void init() {
  
  cp5 = new ControlP5(this);
  //hint(ENABLE_DEPTH_SORT);
  RG.init(this);
  RG.ignoreStyles(ignoringStyles);
  //RG.setPolygonizer(RG.ADAPTATIVE);
  RG.setPolygonizer(RG.UNIFORMLENGTH);
  RG.setPolygonizerLength(polygonizerLength);
  //RG.setPolygonizer(RG.UNIFORMSTEP);
  importer = new Importer("data");

  constructGUI();
  initList();

  // tracer
  importer.loadFiles("backgrounds");
  if (importer.getFiles().size() > 0) {
    //tracer = new Tracer("data/backgrounds/testPfad.svg");
    //tracer = new Tracer(importer.getFiles().get(0));
    for (int i = 0; i<importer.getFiles().size(); i++) {
      tracers.add(new Tracer(importer.getFiles().get(i)));
    }
  }

  // overlay
  importer.loadFiles("overlays");
  if (importer.getFiles().size() > 0) 
    //overlay = loadImage("data/overlays/overlay.png");
    overlay = loadImage(importer.getFiles().get(0)); 

  surface.setLocation(0, 0);


  float[] aspect = calculateAspectRatioFit(setWidth, setHeight, 2480, 720+menuHeight);
  //surface.setSize((int)aspect[0], (int)aspect[1]+menuHeight);
  //surface.setResizable(true);

  buffer[0] = createGraphics(segments[0], setHeight, P3D);
  buffer[1] = createGraphics(segments[1], setHeight, P3D);
  buffer[2] = createGraphics(segments[2], setHeight, P3D);
  
  active = createGraphics(2480, 720, P2D);
  preview = createGraphics(2480, 720, P3D);

  //buffer = createGraphics(overlay.width, overlay.height, SVG, "export/output.svg");
  //importer = new Importer[3];

  //importer[1] = new Importer("data/backgrounds");
  //importer[2] = new Importer("data/text");

  myFont[0] = createFont(fontname+"-Hairline"+suffix, fontSize);
  myFont[1] = createFont(fontname+"-Ultralight"+suffix, fontSize);
  myFont[2] = createFont(fontname+"-Thin"+suffix, fontSize);
  myFont[3] = createFont(fontname+"-Light"+suffix, fontSize);
  myFont[4] = createFont(fontname+"-Regular"+suffix, fontSize);
  myFont[5] = createFont(fontname+"-Medium"+suffix, fontSize);
  myFont[6] = createFont(fontname+"-Bold"+suffix, fontSize);
  myFont[7] = createFont(fontname+"-Heavy"+suffix, fontSize);
  myFont[8] = createFont(fontname+"-Black"+suffix, fontSize);
  
  myFontUpscaled[0] = createFont(fontname+"-Hairline"+suffix, int(fontSize*fontScaling2));
  myFontUpscaled[1] = createFont(fontname+"-Ultralight"+suffix, int(fontSize*fontScaling2));
  myFontUpscaled[2] = createFont(fontname+"-Thin"+suffix, int(fontSize*fontScaling2));
  myFontUpscaled[3] = createFont(fontname+"-Light"+suffix, int(fontSize*fontScaling2));
  myFontUpscaled[4] = createFont(fontname+"-Regular"+suffix, int(fontSize*fontScaling2));
  myFontUpscaled[5] = createFont(fontname+"-Medium"+suffix, int(fontSize*fontScaling2));
  myFontUpscaled[6] = createFont(fontname+"-Bold"+suffix, int(fontSize*fontScaling2));
  myFontUpscaled[7] = createFont(fontname+"-Heavy"+suffix, int(fontSize*fontScaling2));
  myFontUpscaled[8] = createFont(fontname+"-Black"+suffix, int(fontSize*fontScaling2));

  textFont(myFont[4]);
  textSize(fontSize);
  for(int i = 0; i<segments.length; i++) {
    buffer[i].beginDraw();
    buffer[i].textFont(myFontUpscaled[4]);
    buffer[i].textSize(int(fontSize*fontScaling2));
    buffer[i].endDraw();
  }
  
  preview.beginDraw();
  preview.textFont(myFont[4]);
  preview.textSize(fontSize);
  preview.endDraw();

  readyToGo = true;
  initCurrentPathList(currentTracer);
}

void export() {
  if (readyToGo) {
    
    String date = year() +""+ nf(month(), 2) +""+ nf(day(), 2) +"_"+ nf(hour(), 2) +""+ nf(minute(), 2) +""+ nf(second(), 2);
    String fn = "";
    for(int i = 0; i<segments.length; i++) {
      fn = "output_"+ date +"_"+ nf(exportFrame, 5) +"_"+ i +"_.png";
      buffer[i].save("export/"+ fn);
      println("Export: export/"+ fn);
    }
    exportFrame++;
    
  }
}

void showOverlay() {
  if (showOverlay) {
    push();
    blendMode(LIGHTEST);
    image(overlay, 0, menuHeight, width, height-menuHeight);
    pop();
  }
}

void initList() {
  List l = new ArrayList();

  importer.loadFiles("overlays");
  l = new ArrayList();
  l.add("empty");
  for (int i = 0; i<importer.getFiles().size(); i++) {
    String s = importer.getFiles().get(i);
    String[] split = split(s, "/");
    l.add(split[split.length-1]);
  }
  cp5.get(ScrollableList.class, "overlayList").addItems(l);

  importer.loadFiles("backgrounds");
  l = new ArrayList();
  for (int i = 0; i<importer.getFiles().size(); i++) {
    String s = importer.getFiles().get(i);
    String[] split = split(s, "/");
    l.add(split[split.length-1]);
  }
  cp5.get(ScrollableList.class, "backgroundList").addItems(l);

  importer.loadFiles("text");
  l = new ArrayList();
  if (importer.getFiles().size() > 0) {
    clusters = new String[importer.getFiles().size()][];
    for (int i = 0; i<importer.getFiles().size(); i++) {
      clusters[i] = loadStrings(importer.getFiles().get(i));
      String s = importer.getFiles().get(i);
      String[] split = split(s, "/");
      l.add(split[split.length-1]);
    }
    cp5.get(ScrollableList.class, "textList").addItems(l);
  }
}


void cleanCurrentPathList(int currentTracer) {
  cp5.get(ScrollableList.class, "pathList").clear();
}

void initCurrentPathList(int currentTracer) {
  List l = new ArrayList();
  for (int i = 0; i<tracers.get(currentTracer).getPathCount(); i++) {
    l.add("path " + i);
  }
  cp5.get(ScrollableList.class, "pathList").addItems(l);
}

float[] calculateAspectRatioFit(float srcWidth, float srcHeight, float maxWidth, float maxHeight) {
  //float[] result;
  float ratio = Math.min(maxWidth / srcWidth, maxHeight / srcHeight);
  float result[] = {srcWidth*ratio, srcHeight*ratio};
  //return { width: srcWidth*ratio, height: srcHeight*ratio };
  return result;
}
