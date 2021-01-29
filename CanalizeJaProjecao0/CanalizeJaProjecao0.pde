//Walker wk;

Caminho path;

SistemaDeParticulas sis;

void setup() {
  size(1920, 1080);
  sis = new SistemaDeParticulas(50);
  println("opa");
  newCaminho();
  sis.AtribuirCaminho(path);
}


void draw() {
  //path.display();
  background(0,0,0,20);
  sis.Update();
}

void mousePressed() {
  path.addPoint(mouseX, mouseY);
}
void newCaminho() {
  // A path is a series of connected points
  // A more sophisticated path might be a curve
  path = new Caminho(0);
  path.addPoint(width/2, height);
  //path.addPoint(random(0, width/2), random(0, height));
  //path.addPoint(random(width/2, width), random(0, height));
  path.addPoint(width/2, height-2);
  path.Breed();
}
