/**
*    @author Julian Hespenheide (julian@thegreeneyl.com)
*    @version 0.1.0
*
*/

/*
todo
auf dem aktuellen tracer alle pfade als cp5 elemente bekommen
um parameter anpassen zu können
*/

void setup() {
  size(900, 900, P3D);
  pixelDensity(2);
  init();
}

void draw() {   
    background(0);
    
    stateMachine(state);
    buffer.beginDraw();
    buffer.clear();
    
    tracers.get(currentTracer).displayAll();
    buffer.endDraw();
    //buffer.dispose();
    
    // OVERLAY
    image(buffer, 0, menuHeight, width, height-menuHeight);
    
    // show active path
    if(tracers.get(currentTracer).getCurrentPath().getCoords().length > 0) {
      active.beginDraw();
      active.clear();
      active.strokeWeight(4);
      active.push();
      active.beginShape();
      active.stroke(255, 255, 0);
      active.noFill();
      for(int i = 0; i<tracers.get(currentTracer).getCurrentPath().getCoords().length; i++) {
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
}
