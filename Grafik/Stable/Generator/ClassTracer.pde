import geomerative.*;

class Tracer {
  RShape grp;
  RPoint[][] pointPaths;
  ArrayList<Path> paths = new ArrayList<Path>();
  int spacing = 10; // 0 = kein spationieren
  
  long timestamp = 0;
  long interval = 5000;
  
  Tracer(String filename) {
    println("Created a Tracer");
    grp = RG.loadShape(filename);
    //grp.centerIn(g, 100, 1, 1);
    pointPaths = grp.getPointsInPaths();
    initPaths();
    timestamp = millis();
    
  }
  
  void initPaths() {
    if(getPathCount() > 0) {
      for(int i = 0; i<getPathCount(); i++) {
        if(pointPaths[i] != null) {
          //for(int j = 0; j<getPath(i).length; j++){
            //PVector p = new PVector(getPath(i)[j].x, getPath(i)[j].y);
            paths.add(new Path(getPath(i), spacing));
            // zuviele paths
          //}
        }
      }
    }
  }
  
  
  void displayAll() {
    //if(millis() - timestamp > interval) {
      //timestamp = millis();
      buffer.beginDraw();
      for(int i = 0; i<paths.size(); i++) displayTrace(i);
      buffer.endDraw();
    //}
  } 
  void displayTrace(int current) {
    // method 1 paths.get(current).displayTextblock();
    paths.get(current).displayCharacters();
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
      buffer.beginDraw();
      buffer.push();
      buffer.rectMode(CENTER);
      buffer.beginShape();
      buffer.stroke(random(255), random(255), random(255));
      buffer.noFill();
      for(int j = 0; j<getPath(current).length; j++){
        PVector p = new PVector(getPath(current)[j].x, getPath(current)[j].y);
        buffer.vertex(p.x, p.y);
        //DEBUG rect(p.x, p.y, 5, 5);
      }
      buffer.endShape();
      buffer.pop();
      buffer.beginDraw();
    }
  }
  
  int getPathCount() {
    return pointPaths.length;
  }
  
  RPoint[] getPath(int i) {
    return pointPaths[i];
  }

}
