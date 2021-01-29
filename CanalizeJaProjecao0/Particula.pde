public class Particula {

  Walker walker;
  float r;
  
  float tamanho;
  
  Caminho c;

  color[] cores;

  Particula() {
    tamanho = 20;
    this.walker = new Walker();
    cores = new color[2];
    cores[0] = color(random(0,255),random(0,255),random(0,255),random(0,70));
    cores[1] = color(random(0,255),random(0,255),random(0,255),random(50,100));
  }
  
  void setC(Caminho p){
    this.c = p;
  }
  
  void Update() {
    walker.follow(c);
    walker.Update();
    walker.borders(path);
  }
  
  void Display() {
    pushMatrix();
    translate(walker.GetPos().x, walker.GetPos().y);
    strokeWeight(20);
    stroke(cores[0]);
    fill(cores[1]);
    ellipse(0, 0, 3*tamanho, 3*tamanho);
    popMatrix();
  }
}
