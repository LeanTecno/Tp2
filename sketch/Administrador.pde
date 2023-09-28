class Administrador {

  ArrayList <Puntero> punteros;

  FWorld mundo;

  Administrador(FWorld mundo_) {
    punteros = new ArrayList<Puntero>();

    mundo = mundo_;
  }

  void crearPuntero (Blob b) {

    Puntero p = new Puntero(mundo, b.id, b.centroidX * width, b.centroidY * height);
    punteros.add(p);
  }
  void removerPuntero (Blob b) {

    for (int i = punteros.size()-1; i >=0; i--) {
      Puntero p = punteros.get(i);
      if (p.id == b.id) {
        p.borrar();
        punteros.remove(i);
        break;
      }
    }
  }
  void actualizarPuntero (Blob b) {

    for (Puntero p : punteros) {
      if (p.id == b.id) {
        p.setTarget(b.centroidX* width, b.centroidY * height);
        break;
      }
    }
  }
  void dibujar() {
    for (Puntero p : punteros) {
      p.dibujar();
    }
  }
}
