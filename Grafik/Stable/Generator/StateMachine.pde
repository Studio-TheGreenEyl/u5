static final int SETUP = 0;
static final int PREVIEW = 1;
static final int EXPORT = 2;



static final String[] stateNames = {
  "Video Loop", "Atmen", "Lichtstreifen", 
  "Hochwandern", "Soundreaktiv", "Perlin", 
  "Flocking", "PingPong", "H. Wellen", 
  "V. Wellen", "Aufwaerts", "Statische Bilder"
};

String getStateName(int state) {
  return stateNames[state];
}

void setState(int _state) {
  state = _state;
}

void stateMachine(int state) {
  
  switch(state) {
    
    
    case SETUP:
      println("→ Setup");
      // load JSON Settings
      // load Vector file
      //
      setState(PREVIEW);
      
    break;
    
    case PREVIEW:
      
      background(0);
  
      preview.beginDraw();
      preview.clear();
      tracers.get(currentTracer).displayAll();
      preview.endDraw();
  
      // OVERLAY
      for (int i = 0; i<segments.length; i++) {
        image(preview, segments[i]*i, menuHeight, width, height-menuHeight);
      }
  
      // show active path
      if (tracers.get(currentTracer).getCurrentPath().getCoords().length > 0) {
        active.beginDraw();
        active.clear();
        active.strokeWeight(4);
        active.push();
        active.beginShape();
        active.stroke(255, 255, 0);
        active.noFill();
        for (int i = 0; i<tracers.get(currentTracer).getCurrentPath().getCoords().length; i++) {
          PVector p = new PVector(tracers.get(currentTracer).getCurrentPath().getCoords()[i].x, tracers.get(currentTracer).getCurrentPath().getCoords()[i].y);
          active.vertex(p.x, p.y);
        }
        active.endShape();
        active.pop();
        active.endDraw();
        image(active, 0, menuHeight, width, height-menuHeight);
      }
  
      showOverlay();
      push();
      fill(255);
      rect(0, 0, width, menuHeight);
      pop();
      
    break;

    case EXPORT:
      println("→ Export in progress. Please wait while segments are generated for high quality export.");
      background(0);
      for (int i = 0; i<segments.length; i++) {
        buffer[i].beginDraw();
        buffer[i].clear();
        currentBuffer = i;
        tracers.get(currentTracer).displayAll();
        buffer[i].endDraw();
      }
      export();
      println("Done exporting. Switching back to Preview mode");
      setState(PREVIEW);
    break;
    
    
    
  }
}
