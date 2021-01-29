public class SistemaDeParticulas {
  
  Caminho c;
  
    Particula[] particulas;
    int qtdParticulas;
    SistemaDeParticulas(int q) {
      this.qtdParticulas = q;
      particulas = new Particula[q];
      for(int i = 0; i < qtdParticulas; i++) {
        particulas[i] = new Particula();
      }
      
    }
    
    void AtribuirCaminho(Caminho p) {
      this.c = p;
        for(int i = 0; i < qtdParticulas; i++) {
        particulas[i].setC(this.c);
      }
    }
    
    void Update() {
        for(int i = 0; i < qtdParticulas; i++) {
        particulas[i].Update();
        particulas[i].Display();
      }
    }
      
  
  
}
