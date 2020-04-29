class Path {
  // Ein Path besteht aus einer Serie Textblöcken (ArrayList)
  // Rotation, Skalierung können hier abgespeichert werden
  // und auf die Textblöcke auf einer per Objekt Basis übertragen werden
  RPoint[] coords;
  ArrayList<Textblock> blocks = new ArrayList<Textblock>();
  int cluster = 0; // Welche textdatei
  float startRotation = 0;
  float endRatoation = 0;
  float startScale = 0;
  float endScale = 0;
  float strokeWeight = 1;
  int spacing = 0;
  float offsetRotation = 0;
  
  
  Path(RPoint[] _c, int _spacing) {
    coords = _c;
    spacing = _spacing;
    init();
  }
  
  void init() {
    
    for(int i = 0; i<coords.length; i++) {
      PVector p = new PVector(coords[i].x, coords[i].y);
      //println(p);
      blocks.add(new Textblock(p));
    }
    
    // calc atan2
    for(int i = 0; i<blocks.size(); i++) {
      if(i < blocks.size()-1) {
        PVector p1 = blocks.get(i).getPosition();
        PVector p2 = blocks.get(i+1).getPosition();
        float a = atan2(p2.y-p1.y, p2.x-p1.x);
        blocks.get(i).setRotation(a);
      }
    }
  }
  
  void update() {
  }
  void display() {
    if(blocks.size() > 0) {
      
      for(int i = 0; i<blocks.size(); i++) {
        //if(i % spacing == 0) {
          buffer.stroke(255);
          buffer.noFill();
          buffer.rectMode(CENTER);
          blocks.get(i).display();
        //}
      }
    }
  }
  
  void active() {
    strokeWeight = 4;
  }
  
  void inactive() {
    strokeWeight = 1;
  }
  
}

class Textblock {
  PVector p;
  float rotation;
  float scale;
  float tilt;
  String text;
  Textblock(PVector _p) {
    p = _p;
    text = "W";
  }
  
  void update() {
  }
  void display() {
    buffer.push();
    buffer.translate(p.x, p.y);
    
    
    //buffer.ellipse(0, 0, 3, 3);
    
    buffer.rotate(rotation);
    buffer.text(text, 0, 0);
    //buffer.rect(0, 0, 20, 8);
    buffer.pop();
  }
  
  void setRotation(float r) {
    rotation = r;
  }
  
  PVector getPosition() {
    return p;
  }
  
  int getLength() {
    return text.length();
  }
  
  char getCharacter(int index) {
    return text.charAt(index);
  }
  
}
