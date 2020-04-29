Tracer tracer;
int current = 0;

void setup() {
  size(900, 900);
  tracer = new Tracer("testPfad.svg");
  surface.setLocation(0, 0);
}

void draw() {
  background(255);
  //translate(width/2, height/2);
 // tracer.update();
  //tracer.display();
  tracer.displayPath(current);
  //path.show3D();
  
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      current++;
      if(current >= tracer.getPathCount()) current = tracer.getPathCount()-1;
    } else if (keyCode == DOWN) {
      current--;
      if(current <= 0) current = 0;
    }
    println("show path " + (current+1) + " / " + tracer.getPathCount());
  }
}
