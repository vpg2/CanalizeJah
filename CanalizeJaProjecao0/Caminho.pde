// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Path Following

class Caminho {

  // A Path is an arraylist of pontos (PVector objects)
  ArrayList<PVector> pontos;
  // A path has a raio, i.e how far is it ok for the boid to wander off
  float raio;

  Caminho f0;
  Caminho f1;

  int i;

  Caminho(int ii) {
    // Arbitrary raio of 20
    this.raio = 200;
    this.pontos = new ArrayList<PVector>();
    this.i = ii;
  }

  void Breed() {

    if (this.i < 4) {
      f0 = new Caminho(this.i+1);
      f1 = new Caminho(this.i+1);

      f0.addPoint(getEnd().x, getEnd().y);
      f0.addPoint(random(width), getEnd().y/2);

      f1.addPoint(getEnd().x, getEnd().y);
      f1.addPoint(random(width), getEnd().y/2);

      f0.Breed();
      f1.Breed();
    }
  }

  // Add a point to the path
  void addPoint(float x, float y) {
    PVector point = new PVector(x, y);
    pontos.add(point);
  }

  PVector getStart() {
    return pontos.get(0);
  }

  PVector getEnd() {
    return pontos.get(pontos.size()-1);
  }


  // Draw the path
  void display() {
    // Draw thick line for raio
    stroke(175);
    strokeWeight(raio*2);
    noFill();
    beginShape();
    for (PVector v : pontos) {
      vertex(v.x, v.y);
    }
    endShape();
    // Draw thin line for center of path
    stroke(0);
    strokeWeight(1);
    noFill();
    beginShape();
    for (PVector v : pontos) {
      vertex(v.x, v.y);
    }
    endShape();
    if (this.i < 4) {
      f0.display();
      f1.display();
    }
  }
}
