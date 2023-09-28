class Fondo {
  int distanciaX, distanciaY;
  int cantidadX, cantidadY;

  Fondo() {

    cantidadX= 20;
    cantidadY = 30;
  }

  void dibujar(int x_, int y_, int tableroWidth_, int tableroHeight_) {

    distanciaX = tableroWidth_/cantidadX;
    distanciaY = tableroHeight_/cantidadY;

    push();
    for (int x= 0; x <  cantidadX; x ++ ) {
      for (int y=0; y <  cantidadY; y ++ ) {

        stroke(10);
        strokeWeight(2);
        point(x_+10 + x*distanciaX, y_+20+ y*distanciaY);
        //            --------------LINEAS CANCHA
        if (y == 10) {
          stroke(0,0, 255);
          line(x_,   y_ + y*distanciaY  ,  x_+ tableroWidth_  ,  y_+y*distanciaY);
        } else if (y == 21) {
          stroke(0, 0, 255);
          line(x_,   y_+y*distanciaY  ,  x_+tableroWidth_  ,  y_+y*distanciaY);
        }


      }
    }
    pop();
    push();

    strokeWeight(6);
    rect(x_, y_, tableroWidth_, tableroHeight_);
    circle(x_+tableroWidth_/2,y_+tableroHeight_/2, 95);
    pop();
  }
}
