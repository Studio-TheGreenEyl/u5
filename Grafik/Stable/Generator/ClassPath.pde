class Path {
  // Ein Path besteht aus einer Serie Textblöcken (ArrayList)
  // Rotation, Skalierung können hier abgespeichert werden
  // und auf die Textblöcke auf einer per Objekt Basis übertragen werden
  RPoint[] coords;
  ArrayList<Textblock> blocks = new ArrayList<Textblock>();
  int cluster = 1; // Welche textdatei
  int clusterStep = 0;
  int[] rX = new int[2];
  int[] rY = new int[2];
  
  float startScale = 0;
  float endScale = 0;
  float strokeWeight = 1;
  int spacing = 0;
  float offsetRotation = 0;  
  
  String textString = "";
  int maxLengthOfString = 0;
  
  
  Path(RPoint[] _c, int _spacing) {
    coords = _c;
    spacing = _spacing;
    init();
    clusterStep = (int)random(clusters[clusterStep].length-1);
    println("Path created");
    rX[0] = (int)random(-45);
    rX[1] = (int)random(45);
    rY[0] = (int)random(-33);
    rY[1] = (int)random(33);
    IntList order = new IntList();
    for(int i = 0; i<blocks.size(); i++) order.append(i);
    order.shuffle();
    
    for(int i = 0; i<blocks.size(); i++) textString += blocks.get(order.get(i)).getString() + " ";  
  }
  
  void init() {
    
    for(int i = 0; i<coords.length; i++) {
      //PVector p = new PVector(coords[i].x, coords[i].y);
      //println(p);
      
    }
    
    for(int i = 0; i<clusters[cluster].length; i++) {
      blocks.add(new Textblock(clusters[cluster][i]));
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
  
  //Simple function to calculate the angle between two points
  float getAngle(RPoint p1, RPoint p2){
    float deltax = p1.x - p2.x;
    float deltay = p1.y - p2.y;
    return atan(deltay/deltax);
  }
  
  void update() {
  }
  
  void displayTextblock() {
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
  
  void displayCharacters() {
    if(blocks.size() > 0) {
      
      int characterStep = 0;
      for(int i = 0; i<coords.length; i++) {
        PVector p = new PVector(coords[i].x, coords[i].y);
        Textblock b = blocks.get(clusterStep);
        int l = b.getLength();
        buffer.push();
        if(l > 0) {
          
          char c = b.getCharacter(characterStep);
          
          
          if(i < coords.length - 1) {
            RPoint center = new RCommand(coords[i], coords[i+1]).getCenter();
            buffer.translate(center.x, center.y);
          } else {
           // buffer.translate(p.x, p.y);
          }
          
          float xR = map(i, 0, coords.length, rX[0], rX[1]);
          float yR = map(i, 0, coords.length, rY[0], rY[1]);
          
          buffer.rotateX(radians(int(xR)));
          buffer.rotateY(radians(int(yR)));
          if(i < coords.length - 1) {
            buffer.rotateZ(getAngle(coords[i], coords[i+1]));
          }
          
          buffer.text(c, 0, 0);
          if(characterStep < l) characterStep++;
          
          if(characterStep >= l) {
            //characterStep = 0;
            //clusterStep++;
            //clusterStep %= blocks.size();
          }
          
        }
        buffer.pop();        
      }
    }
  }
  
  void displayCharacters2() {
    float x = 0;
    int l = textString.length();
    if(blocks.size() > 0) {
      int offsetKern = 0;
      int characterStep = 0;
      for(int i = 0; i<coords.length; i++) {
        PVector p = new PVector(coords[i].x, coords[i].y);
        buffer.push();
        if(l > 0) {
          char c = textString.charAt(characterStep);
          float lw = textWidth(c) * kerning;
          if(str(c).equals("I") || str(c).equals("i")) offsetKern += 10;
          if(i < coords.length-1) {
            RPoint center = new RCommand(coords[i], coords[(i+1)]).getCenter();
            buffer.translate(center.x, center.y);
          }
          //else {
            //buffer.translate(p.x, p.y);
          //}
          
          float xR = map(i, 0, coords.length, rX[0], rX[1]);
          float yR = map(i, 0, coords.length, rY[0], rY[1]);
          float size = map(i, 0, coords.length, 0.0, 1.0);
          buffer.rotateX(radians(int(xR)));
          //buffer.rotateY(radians(int(yR)));
          if(i < coords.length - 1) {
            buffer.rotateZ(getAngle(coords[i], coords[i+1]));
          }
          buffer.textFont(myFont[floor(size*9)]);
          buffer.text(c, 0, 0);
          //characterStep++;
          if(characterStep < l) characterStep++;
          if(characterStep >= l) {
            //characterStep = 0;
            //clusterStep++;
            //clusterStep %= blocks.size();
          }
          
        }
        buffer.pop();        
      }
    }
  }
  
  void displayCharacters3() {
    float x = 0;
    int l = textString.length();
    if(blocks.size() > 0) {
      int offsetKern = 0;
      int characterStep = 0;
      for(int i = 0; i<coords.length-1; i++) {
        offsetKern = 0;
        PVector p = new PVector(coords[i].x, coords[i].y);
        buffer.push();
        if(l > 0) {
          char c = textString.charAt(characterStep);
          float lw = textWidth(c) * kerning;
          if(str(c).equals("I") || str(c).equals("i")) {
            //offsetKern += 10;
            //println("i = " + lw);
            offsetKern = (int)lw/2;
          } else {
            //println(c +" = " + lw);
          }
          //if(i < coords.length-1) {
            RPoint center = new RCommand(coords[i], coords[(i+1)]).getCenter();
            buffer.translate(center.x+offsetKern, center.y);
          //}
          //else {
            //buffer.translate(p.x, p.y);
          //}
          
          float xR = map(i, 0, coords.length, rX[0], rX[1]);
          float yR = map(i, 0, coords.length, rY[0], rY[1]);
          float size = map(i, 0, coords.length, 0.0, 0.6);
          buffer.rotateX(radians(int(xR)));
          //buffer.rotateY(radians(int(yR)));
          if(i < coords.length - 1) {
            buffer.rotateZ(getAngle(coords[i], coords[i+1]));
          }
          buffer.textFont(myFont[floor(size*9)]);
          buffer.text(c, 0, 0);
          //characterStep++;
          if(characterStep < l) characterStep++;
          if(characterStep >= l) {
            //characterStep = 0;
            //clusterStep++;
            //clusterStep %= blocks.size();
          }
          
        }
        buffer.pop();        
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
  float tracking;
  Textblock(String s) {
    //p = _p;
    p = new PVector(0, 0);
    text = s;
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
    if(index >= getLength()) return ' '; 
    else return text.charAt(index);
  }
  
  String getString() {
    return text;
  }
  
}
