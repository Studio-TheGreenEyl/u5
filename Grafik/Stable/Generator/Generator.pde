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
  size(2480, 720, P3D);
  //textMode(SHAPE);
  //pixelDensity(2);
  init();
}

void draw() {
    stateMachine(state);
    
}
