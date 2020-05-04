import geomerative.*;

class Tracer {
  RShape grp;
  RPoint[][] pointPaths; // not-scaled
  RPoint[][] upscaledPointPaths; // upscaled to endformat
  
  ArrayList<Path> paths = new ArrayList<Path>();
  int spacing = 10; // 0 = kein spationieren
  
  long timestamp = 0;
  long interval = 5000;
  
  Tracer(String filename) {
    println("Created a Tracer");
    grp = RG.loadShape(filename);
    //grp.centerIn(g, 100, 1, 1);
    pointPaths = grp.getPointsInPaths();
    upscaledPointPaths = grp.getPointsInPaths();
    
    
    for(int i = 0; i<pointPaths.length; i++) {
      for(int j = 0; j<pointPaths[i].length; j++) {
        upscaledPointPaths[i][j].x *= scaleFactor;
        upscaledPointPaths[i][j].y *= scaleFactor;
      }
    }
    
    initPaths();
    timestamp = millis();
    
  }
  
  void initPaths() {
    if(getPathCount() > 0) {
      for(int i = 0; i<getPathCount(); i++) {
        if(pointPaths[i] != null) {
          //for(int j = 0; j<getPath(i).length; j++){
            //PVector p = new PVector(getPath(i)[j].x, getPath(i)[j].y);
            paths.add(new Path(getPath(i), getPathUpscaled(i), spacing));
            // zuviele paths
          //}
        }
      }
    }
  }
  
  
  void displayAll() {
    //if(millis() - timestamp > interval) {
      //timestamp = millis();
      
      
      for(int i = 0; i<paths.size(); i++) displayTrace(i);
      
    //}
  } 
  void displayTrace(int current) {
    // method 1 paths.get(current).displayTextblock();
    //paths.get(current).displayCharacters();
    paths.get(current).displayCharacters3();
  }
  
  // Debug Ansicht
  void debugDisplayAll() {
    if(getPathCount() > 0) {
      for(int i = 0; i<getPathCount(); i++) {
        debugDisplayPath(i);
      }
    }
  }
  
  // Debug Ansicht
  void debugDisplayPath(int current) {
    if(pointPaths[current] != null) {
      buffer[currentBuffer].beginDraw();
      buffer[currentBuffer].push();
      buffer[currentBuffer].rectMode(CENTER);
      buffer[currentBuffer].beginShape();
      buffer[currentBuffer].stroke(random(255), random(255), random(255));
      buffer[currentBuffer].noFill();
      for(int j = 0; j<getPath(current).length; j++){
        PVector p = new PVector(getPath(current)[j].x, getPath(current)[j].y);
        buffer[currentBuffer].vertex(p.x, p.y);
        //DEBUG rect(p.x, p.y, 5, 5);
      }
      buffer[currentBuffer].endShape();
      buffer[currentBuffer].pop();
      buffer[currentBuffer].beginDraw();
    }
  }
  
  int getPathCount() {
    return pointPaths.length;
  }
  
  RPoint[] getPath(int i) {
    return pointPaths[i];
  }
  
  RPoint[] getPathUpscaled(int i) {
    return upscaledPointPaths[i];
  }
  
  Path getCurrentPath() {
    return paths.get(currentPath);
  }

}
