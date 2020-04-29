/**
*    @author Julian Hespenheide (julian@thegreeneyl.com)
*    @version 0.1.0
*
*/

void setup() {
  size(900, 900, P3D);
  init();
}

void draw() {
  //if(refresh) {
    background(0);
    
    stateMachine(state);
    buffer.beginDraw();
    buffer.clear();
    buffer.endDraw();
    tracers.get(currentTracer).displayAll();
    
    // OVERLAY
    
    image(buffer, 0, menuHeight, width, height-menuHeight);
    showOverlay();
    push();
    fill(255);
    rect(0, 0, width, menuHeight);
    pop();
    refresh = false;
 //  }
}
