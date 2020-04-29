class Tracer {
  //ArrayList
  ArrayList<ArrayList<PVector>> paths = new ArrayList<ArrayList<PVector>>();
  
  PShape s;
  int vcount;
  int current = 0;

  int totalVertices = 0;
  int vertAvg = 0;
  
  
  Tracer(String filename) {
    s = loadShape(filename);
    //println("rocket.getChild(0).getVertex(0):\n  ", s.getChild(0).getVertex(0), "\n");
    //// get summary counts
    vcount = getChildrenVertexCount(s);
    fillListChildVertices(s);
    //printChildVertices(s);
    //plotChildVertices(s);
    
  }
  
  void step() {
    current++;
    if (current >= totalVertices/vertAvg) current = 0;
  }

  void update() {
    step();
  }

  void display() {
    push();
      translate(width/2, height/2);
      push();
//        translate(path.get(current).x, path.get(current).y, path.get(current).z);
        //sphere(2);
        point(0, 0);
      pop();
    pop();
  }
  
  void displayPath(int k) {
    push();
    rectMode(CENTER);
    beginShape();
    stroke(random(255), random(255), random(255));
    noFill();
    for(int i = 0; i<paths.get(k).size(); i++) {
      PVector p = new PVector(paths.get(k).get(i).x, paths.get(k).get(i).y);
      vertex(p.x, p.y);
      rect(p.x, p.y, 5, 5);
    }
    endShape();
    pop();
  }
  
  int getPathCount() {
    return paths.size();
  }
  
  
  void printChildVertices(PShape shape) {
    for (int i=0; i<shape.getChildCount(); i++) {
      PShape child = shape.getChild(i);
      for (int j=0; j<child.getVertexCount(); j++) {
        PVector vert = child.getVertex(j);
        println(vert);
      }
    }
    println("");
  }

  void plotChildVertices(PShape shape) {
    for (int i=0; i<shape.getChildCount(); i++) {
      PShape child = shape.getChild(i);
      push();
      noFill();
      beginShape();
      stroke(random(255), random(255), random(255)); 
      for (int j=0; j<child.getVertexCount(); j++) {
        PVector vert = child.getVertex(j);
        //println(vert);
        vertex(vert.x, vert.y);
      }
      endShape();
      pop();
    }
    //println("");
  }

  void fillListChildVertices(PShape shape) {

    for (int i=0; i<shape.getChildCount(); i++) {
      PShape child = shape.getChild(i);
      paths.add(new ArrayList<PVector>());
      
      for (int j=0; j<child.getVertexCount(); j++) {
        PVector vert = null;
        //if (j % vertAvg == 0) {
          vert = child.getVertex(j);
          println("j= "+ j + " | " + vert);
          //exit();
          paths.get(paths.size()-1).add(vert);
        //}
        //println(vert.z);
        //point(vert.x, vert.y, vert.z);
      }
    }
    //println("");
  }



  int getChildrenVertexCount(PShape shape) {
    int vertexCount = 0;
    for (PShape child : shape.getChildren()) {
      vertexCount += child.getVertexCount();
    }
    int childCount = shape.getChildCount();
    totalVertices = vertexCount;
    vertAvg = (int) vertexCount/childCount;
    println("Vertex count:", vertexCount);
    println("Child shapes:", childCount);
    println("Vert/children", vertAvg, "\n");
    // vertexCount/float(childCount)
    return vertexCount;
  }
  
}
