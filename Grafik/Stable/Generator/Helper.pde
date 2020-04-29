import controlP5.*;

ControlP5 cp5; 
ArrayList<Tracer> tracers = new ArrayList<Tracer>();
Importer importer; // overlays, backgrounds, texts

PGraphics buffer;
PImage overlay;

// boolean section
boolean ignoringStyles = true;
boolean showOverlay = true;
boolean cp5AutoDraw = true;
boolean refresh = true;
int currentTracer = 0;

int menuHeight = 30;

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      //current++;
      //if(current >= tracer.getPathCount()) current = tracer.getPathCount()-1;
    } else if (keyCode == DOWN) {
      //current--;
      //if(current <= 0) current = 0;
    }
    //println("show path " + (current+1) + " / " + tracer.getPathCount());
  }
}

void init() {
   cp5 = new ControlP5(this);
 
  RG.init(this);
  RG.ignoreStyles(ignoringStyles);
  //RG.setPolygonizer(RG.ADAPTATIVE);
  RG.setPolygonizer(RG.UNIFORMLENGTH);
  RG.setPolygonizerLength(10);
  //RG.setPolygonizer(RG.UNIFORMSTEP);
  importer = new Importer("data");
  
  constructGUI();
  initList();
  
  // tracer
  importer.loadFiles("backgrounds");
  if(importer.getFiles().size() > 0) {
  //tracer = new Tracer("data/backgrounds/testPfad.svg");
  //tracer = new Tracer(importer.getFiles().get(0));
    for(int i = 0; i<importer.getFiles().size(); i++) {
      tracers.add(new Tracer(importer.getFiles().get(i)));
    }
  }
  
  // overlay
  importer.loadFiles("overlays");
  if(importer.getFiles().size() > 0) 
  //overlay = loadImage("data/overlays/overlay.png");
  overlay = loadImage(importer.getFiles().get(0)); 
  
  surface.setLocation(0, 0);
  
  
  float[] aspect = calculateAspectRatioFit(overlay.width, overlay.height, 1400, 1400);
  surface.setSize((int)aspect[0], (int)aspect[1]+menuHeight);
  surface.setResizable(true);
  
  buffer = createGraphics(overlay.width, overlay.height);
  //importer = new Importer[3];
  
  //importer[1] = new Importer("data/backgrounds");
  //importer[2] = new Importer("data/text");
  
  
  
  

}

void showOverlay() {
  if(showOverlay) {
    buffer.beginDraw();
    buffer.push();
    buffer.blendMode(LIGHTEST);
    buffer.image(overlay, 0, 0);
    buffer.pop();
    buffer.endDraw();
  }
}



void initList() {
  List l = new ArrayList();
      
  importer.loadFiles("overlays");
  l = new ArrayList();
  for(int i = 0; i<importer.getFiles().size(); i++) {
    String s = importer.getFiles().get(i);
    String[] split = split(s, "/");
    l.add(split[split.length-1]);
  }
  cp5.get(ScrollableList.class, "overlayList").addItems(l);
  
  importer.loadFiles("backgrounds");
  l = new ArrayList();
  for(int i = 0; i<importer.getFiles().size(); i++) {
    String s = importer.getFiles().get(i);
    String[] split = split(s, "/");
    l.add(split[split.length-1]);
  }
  cp5.get(ScrollableList.class, "backgroundList").addItems(l);
}
  
float[] calculateAspectRatioFit(float srcWidth, float srcHeight, float maxWidth, float maxHeight) {
  //float[] result;
  float ratio = Math.min(maxWidth / srcWidth, maxHeight / srcHeight);
  float result[] = {srcWidth*ratio, srcHeight*ratio};
  //return { width: srcWidth*ratio, height: srcHeight*ratio };
  return result;
}
