import geomerative.*;

class Tracer {
  RShape grp;
  RPoint[][] pointPaths;
  
  
  Tracer(String filename) {
    grp = RG.loadShape(filename);
    //grp.centerIn(g, 100, 1, 1);
    pointPaths = grp.getPointsInPaths();
  }
  
  void displayAll() {
    if(getPathCount() > 0) {
      for(int i = 0; i<getPathCount(); i++) {
        displayPath(i);
      }
    }
  }
  
  void displayPath(int current) {
    if(pointPaths[current] != null) {
      push();
      rectMode(CENTER);
      beginShape();
      stroke(random(255), random(255), random(255));
      noFill();
      for(int j = 0; j<getPath(current).length; j++){
        PVector p = new PVector(getPath(current)[j].x, getPath(current)[j].y);
        vertex(p.x, p.y);
        //DEBUG
        rect(p.x, p.y, 5, 5);
      }
      endShape();
      pop();
    }
  }
  
  int getPathCount() {
    return pointPaths.length;
  }
  
  RPoint[] getPath(int i) {
    return pointPaths[i];
  }

}
