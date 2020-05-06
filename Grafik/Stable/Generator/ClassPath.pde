class Path {
  // Ein Path besteht aus einer Serie Textblöcken (ArrayList)
  // Rotation, Skalierung können hier abgespeichert werden
  // und auf die Textblöcke auf einer per Objekt Basis übertragen werden
  RPoint[] coords;
  RPoint[] upscaledCoords;
  ArrayList<Textblock> blocks = new ArrayList<Textblock>();
  int cluster = 0; // Welche textdatei
  int clusterStep = 0;
  int[] rX = new int[2];
  int[] rY = new int[2];
  float[] fontSize = new float[2];
  
  
  float startScale = 0;
  float endScale = 0;
  float strokeWeight = 1;
  int spacing = 0;
  float offsetRotation = 0;  
  
  String textString = "";
  int maxLengthOfString = 0;
  
  boolean uppercase = true;
  
  boolean rotModeX = false;
  boolean rotModeY = false;
  
  // path effects
  /*
    rotation per char or path
    limit characters
    font size
    font weight
    kerning
    visible/hidden
  */
  
  int cutoff;
  float cutoffFloat;
  
  Path(RPoint[] _coords, RPoint[] _upscaled, int _spacing) {
    coords = _coords;
    upscaledCoords = _upscaled;
    spacing = _spacing;
    init();
    clusterStep = (int)random(clusters[clusterStep].length-1);
    println("Path created");
    rX[0] = 0;
    rX[1] = 0;
    rY[0] = 0;
    rY[1] = 0;
    initText();
      
    cutoff = coords.length;
    cutoffFloat = 1.0;
  }
  
  void initText() {
    textString = "";
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
          buffer[0].stroke(255);
          buffer[0].noFill();
          buffer[0].rectMode(CENTER);
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
        buffer[currentBuffer].push();
        if(l > 0) {
          
          char c = b.getCharacter(characterStep);
          
          
          if(i < coords.length - 1) {
            RPoint center = new RCommand(coords[i], coords[i+1]).getCenter();
            buffer[currentBuffer].translate(center.x, center.y);
          } else {
           // buffer.translate(p.x, p.y);
          }
          
          float xR = map(i, 0, coords.length, rX[0], rX[1]);
          float yR = map(i, 0, coords.length, rY[0], rY[1]);
          
          buffer[currentBuffer].rotateX(radians(int(xR)));
          buffer[currentBuffer].rotateY(radians(int(yR)));
          if(i < coords.length - 1) {
            buffer[currentBuffer].rotateZ(getAngle(coords[i], coords[i+1]));
          }
          
          buffer[0].text(c, 0, 0);
          if(characterStep < l) characterStep++;
          
          if(characterStep >= l) {
            //characterStep = 0;
            //clusterStep++;
            //clusterStep %= blocks.size();
          }
          
        }
        buffer[currentBuffer].pop();
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
        buffer[currentBuffer].push();
        if(l > 0) {
          char c = textString.charAt(characterStep);
          float lw = textWidth(c) * kerning;
          if(str(c).equals("I") || str(c).equals("i")) offsetKern += 10;
          if(i < coords.length-1) {
            RPoint center = new RCommand(coords[i], coords[(i+1)]).getCenter();
            buffer[currentBuffer].translate(center.x, center.y);
          }
          //else {
            //buffer.translate(p.x, p.y);
          //}
          
          float xR = map(i, 0, coords.length, rX[0], rX[1]);
          float yR = map(i, 0, coords.length, rY[0], rY[1]);
          float size = map(i, 0, coords.length, 0.0, 1.0);
          buffer[0].rotateX(radians(int(xR)));
          //buffer.rotateY(radians(int(yR)));
          if(i < coords.length - 1) {
            buffer[currentBuffer].rotateZ(getAngle(coords[i], coords[i+1]));
          }
          buffer[currentBuffer].textFont(myFont[floor(size*9)]);
          buffer[currentBuffer].text(c, 0, 0);
          //characterStep++;
          if(characterStep < l) characterStep++;
          if(characterStep >= l) {
            //characterStep = 0;
            //clusterStep++;
            //clusterStep %= blocks.size();
          }
          
        }
        buffer[currentBuffer].pop();        
      }
    }
  }
  
  void displayCharacters3() {
    float x = 0;
    int l = textString.length();
    if(blocks.size() > 0) {
      int offsetKern = 0;
      int characterStep = 0;
      
      for(int i = 0; i<cutoff-1; i++) {
        float xR = map(i, 0, coords.length, rX[0], rX[1]);
        float yR = map(i, 0, coords.length, rY[0], rY[1]);
        offsetKern = 0;
        PVector p = new PVector(coords[i].x, coords[i].y);
        
        if(state == EXPORT) buffer[currentBuffer].push();
        else preview.push();
        
        int xOffset = 0;
        if(currentBuffer == 0) xOffset = 0;
        else if(currentBuffer == 1) xOffset = -16000;
        else if(currentBuffer == 2) xOffset = -32000;
        
        
        if(state == EXPORT) buffer[currentBuffer].translate(xOffset, 0);
        
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
            RPoint center = null;
            
            if(uppercase) c = Character.toUpperCase(c);
            
            if(state == EXPORT) {
              center = new RCommand(upscaledCoords[i], upscaledCoords[(i+1)]).getCenter();
              buffer[currentBuffer].translate(center.x+offsetKern, center.y);
            } else {
              center = new RCommand(coords[i], coords[(i+1)]).getCenter();
              preview.translate(center.x+offsetKern, center.y);
            }
          //}
          //else {
            //buffer.translate(p.x, p.y);
          //}
          
          
          //float size = map(i, 0, coords.length, 0.0, 0.6);
          float size = map(i, 0, coords.length, fontSize[0], fontSize[1]);
          if(state == EXPORT) {
            if(!rotModeX) buffer[currentBuffer].rotateX(radians(int(xR)));
            else buffer[currentBuffer].rotateY(radians(int(rX[1])));
            
            if(!rotModeY) buffer[currentBuffer].rotateY(radians(int(yR)));
            else buffer[currentBuffer].rotateY(radians(int(rY[1])));
          } else {
            if(!rotModeX) preview.rotateX(radians(int(xR)));
            else preview.rotateX(radians(int(rX[1])));
            
            if(!rotModeY) preview.rotateY(radians(int(yR)));
            else preview.rotateY(radians(int(rY[1])));
          }
          if(i < coords.length - 1) {
            if(state == EXPORT) buffer[currentBuffer].rotateZ(getAngle(upscaledCoords[i], upscaledCoords[i+1]));
            else preview.rotateZ(getAngle(coords[i], coords[i+1]));
          }
          if(state == EXPORT) {
            buffer[currentBuffer].textFont(myFontUpscaled[floor(size*9)]);
            buffer[currentBuffer].text(c, 0, 0);
          } else {
            
            preview.textFont(myFont[floor(size*9)]);
            preview.text(c, 0, 0);
            preview.textFont(myFont[floor(size*9)]);
            preview.text(c, 0, 0);
            preview.textFont(myFont[floor(size*9)]);
            preview.text(c, 0, 0);
          }
          //characterStep++;
          if(characterStep < l) characterStep++;
          if(characterStep >= l) {
            //characterStep = 0;
            //clusterStep++;
            //clusterStep %= blocks.size();
          }
          
        }
        if(state == EXPORT) buffer[currentBuffer].pop();
        else preview.pop();
      }
    }
  }
  
 
  
  void active() {
    strokeWeight = 4;
  }
  
  void inactive() {
    strokeWeight = 1;
  }
  
  void setRotationX(float a, float b) {
    /*rX[0] = (int)map(a, 0f, 1f, 0, 360);
    rX[1] = (int)map(b, 0f, 1f, 0, 360);
    */
    rX[0] = (int)a;
    rX[1] = (int)b;
  }
  
  void setRotationY(float a, float b) {
    /*rX[0] = (int)map(a, 0f, 1f, 0, 360);
    rX[1] = (int)map(b, 0f, 1f, 0, 360);
    */
    rY[0] = (int)a;
    rY[1] = (int)b;
  }
  
  void setFontSize(float a, float b) {
    /*rX[0] = (int)map(a, 0f, 1f, 0, 360);
    rX[1] = (int)map(b, 0f, 1f, 0, 360);
    */
    fontSize[0] = a;
    fontSize[1] = b;
  }
  
  RPoint[] getCoords() {
    return coords;
  }
  
  RPoint[] getCoordsUpscaled() {
    return upscaledCoords;
  }
  
  void setCluster(int n) {
    cluster = n;
  }
  
  int getCluster() {
    return cluster;
  }
  
  void setClusterAndInit(int n) {
    setCluster(n);
    initText();
  }
  
  void setCutoff(float n) {
    cutoff = (int)map(n, 0f, 1f, 0, coords.length);
    cutoffFloat = n;
  }
  
  float getCutoff() {
    return cutoffFloat;
  }
  
  void setRotModeX(boolean b) {
    rotModeX = b;
  }
  
  void setRotModeY(boolean b) {
    rotModeY = b;
  }
  
  boolean getRotModeX() {
    return rotModeX;
  }
  
  boolean getRotModeY() {
    return rotModeY;
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
    buffer[currentBuffer].push();
    buffer[currentBuffer].translate(p.x, p.y);
    
    
    //buffer.ellipse(0, 0, 3, 3);
    
    buffer[currentBuffer].rotate(rotation);
    buffer[currentBuffer].text(text, 0, 0);
    //buffer.rect(0, 0, 20, 8);
    buffer[currentBuffer].pop();
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
