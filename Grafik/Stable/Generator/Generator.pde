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
    showOverlay();
    push();
    fill(255);
    rect(0, 0, width, menuHeight);
    pop();
}
