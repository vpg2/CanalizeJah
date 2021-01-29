public class Walker {
  PVector posicao;
  PVector velocidade;
  PVector aceleracao;
  PVector forcaResultante;

  float massa;
  float r;

  float maxForce;
  float maxSpeed;

  Walker() {
    this.massa = random(0.2, 0.5);
    this.r = 4;
    this.maxForce = random(0.5, 0.8);
    this.maxSpeed = random(5,10);
    this.posicao = new PVector(random(0, width),height);
    this.velocidade = new PVector(0, 0);
    this.aceleracao = new PVector(0, 0);
    this.forcaResultante = new PVector(0, 0);
  }

  public void Update() {
    println("forcaResultante = "+forcaResultante);
    CalcAcel();
    println("aceleracao = "+aceleracao);
    this.Walk();
    println("velocidade = "+velocidade);
    //this.Display();
    this.forcaResultante = new PVector(0, 0);
    this.aceleracao = new PVector(0, 0);
  }

  void CalcAcel() {
    this.aceleracao = PVector.div(this.forcaResultante, massa);
  }

  public void ApplyForce(PVector f) {
    forcaResultante.add(f);
  }

  public void Display() {
    pushMatrix();
    translate(this.posicao.x, this.posicao.y);
    ellipse(0, 0, 30, 30);
    popMatrix();
  }

  public void Walk() {
    this.velocidade.add(aceleracao);
    velocidade.limit(maxSpeed);
    
    this.posicao.add(this.velocidade);
  }





  public PVector GetPos() {
    return this.posicao;
  }

  public PVector GetAcel() {
    return this.aceleracao;
  }

  public PVector GetForcaResultante() {
    return this.forcaResultante;
  }

  public void SetPos(PVector p) {
    this.posicao = p.copy();
  }

  public void SetAcel(PVector a) {
    this.aceleracao = a.copy();
  }

  public void SetForcaResultante(PVector f) {
    this.forcaResultante = f.copy();
  }

  void follow(Caminho c) {
    PVector prever = this.velocidade.copy();
    prever.normalize();
    prever.mult(50);
    PVector preverPos = PVector.add(this.posicao, prever);

    PVector normal = null;
    PVector alvo = null;
    float worldRecord = 1000000;

    for (int i = 0; i < c.pontos.size()-1; i++) {

      PVector a = c.pontos.get(i);
      PVector b = c.pontos.get(i+1);

      PVector pontoNormal = getNormalPoint(preverPos, a, b);

      if (pontoNormal.x < a.x || pontoNormal.x > b.x) {
        pontoNormal = b.copy();
      }


      float distancia = PVector.dist(preverPos, pontoNormal);

      if (distancia < worldRecord) {
        worldRecord = distancia;
        normal = pontoNormal;
        PVector dir = PVector.sub(b, a);
        dir.normalize();
        dir.mult(10);
        alvo = pontoNormal.copy();
        alvo.add(dir);
      }
    }
    if (worldRecord > c.raio) {
      buscar(alvo);
    }
    
    
    
    
    
    
    
    //stroke(0);
    //  fill(0);
    //  line(posicao.x, posicao.y, preverPos.x, preverPos.y);
    //  ellipse(preverPos.x, preverPos.y, 4, 4);

    //  // Draw normal posicao
    //  stroke(0);
    //  fill(0);
    //  ellipse(normal.x, normal.y, 4, 4);
    //  // Draw actual alvo (red if steering towards it)
    //  line(preverPos.x, preverPos.y, normal.x, normal.y);
    //  if (worldRecord > c.raio) fill(255, 0, 0);
    //  noStroke();
    //  ellipse(alvo.x, alvo.y, 8, 8);
    
    
    
    
    
    
  }

  PVector getNormalPoint(PVector p, PVector a, PVector b) {
    // Vector from a to p
    PVector ap = PVector.sub(p, a);
    // Vector from a to b
    PVector ab = PVector.sub(b, a);
    ab.normalize(); // Normalize the line
    // Project vector "diff" onto line by using the dot product
    ab.mult(ap.dot(ab));
    PVector normalPoint = PVector.add(a, ab);
    return normalPoint;
  }
  
  void buscar(PVector alvo) {
    PVector desired = PVector.sub(alvo, posicao);  // A vector pointing from the posicao to the alvo

    // If the magnitude of desired equals 0, skip out of here
    // (We could optimize this to check if x and y are 0 to avoid mag() square root
    if (desired.mag() == 0) return;

    // Normalize desired and scale to maximum speed
    desired.normalize();
    desired.mult(maxSpeed);
    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired, velocidade);
    steer.limit(maxForce);  // Limit to maximum steering force

    ApplyForce(steer);
  }


  void borders(Caminho p) {
    //if (posicao.x > p.getEnd().x + r) {
    //  posicao.x = p.getStart().x - r;
    //  posicao.y = p.getStart().y + (posicao.y-p.getEnd().y);
    //}
  }
}
