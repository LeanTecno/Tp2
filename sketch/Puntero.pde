class Puntero {

  float id;
  float x;
  float y;
  float xMap;
  float yMap;

  float diametro;
  
  float limiteX = 290;
  float limiteY =620;

  FWorld mundo;
  FCircle controlador;
  FMouseJoint manija;

  Puntero(FWorld mundo_, float id_, float x_, float y_) {
    mundo = mundo_;
    diametro= 40;

    xMap = map(x_, 0, width, 0, limiteX);
    yMap = map(y_, 0, height, 150, limiteY);
    controlador = new FCircle (diametro);
    controlador.setPosition(xMap, yMap);
    controlador.setNoStroke();
    controlador.setFill(255, 0, 0);
    controlador.setRestitution(0.2);

    id = id_;
    manija = new FMouseJoint(controlador, xMap, yMap);

    mundo.add(controlador);
    mundo.add(manija);
  }
  void setTarget(float nx, float ny) {
    
    xMap = map(nx, 100, width, 50, limiteX);
    yMap = map(ny, 0, height, 150, limiteY);
    manija.setTarget(nx, ny);
  }
  void setID(float id) {
    this.id= id;
  }
  void borrar() {
    mundo.remove(manija);
    mundo.remove(controlador);
  }
  void dibujar() {
  }
}
