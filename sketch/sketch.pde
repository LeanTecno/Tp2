import processing.sound.*;
import fisica.*;

FWorld mundo;

int PUERTO_OSC = 12345;

Receptor receptor;
Administrador admin;

// variables de física
// lados rebote
FBox lado_izq;
FBox lado_der;
FBox caja_inf_izq;
FBox caja_inf_der;
FBox caja_sup_izq;
FBox caja_sup_der;

//variables de sonido


BrownNoise fx_noise;
WhiteNoise fx_noise2;
SoundFile fx_choque;

FCircle controlador;
FCircle tejo;


Contadores contadores;

Fondo fondo;

int goles;
int objetivo_goles = 3;

float punteroX;
float punteroY;
float xMap;
float yMap;

void setup() {


  size(600, 600);

  //iniciamos el mundo
  Fisica.init(this);
  mundo = new FWorld();
  mundo.setGravity(-0, 0);
  mundo.setEdges();

  //osc
  setupOSC(PUERTO_OSC);
  receptor = new Receptor();
  admin = new Administrador(mundo);

  //sonido

  fx_noise = new BrownNoise(this);
  fx_noise2 = new WhiteNoise(this);
  fx_noise.amp(0.05);




  //fondo
  contadores = new Contadores();
  fondo = new Fondo();

  //controlador = crearManija(mouseX, mouseY, 40, 1000);
  controlador = new FCircle (40);
  controlador.setPosition(200, 400);
  controlador.setNoStroke();
  controlador.setFill(255, 0, 0);
  controlador.setRestitution(0.2);


  tejo = crearTejo(30, 10);
  tejo.setRestitution(0.6);//indice de rebotabilidad
  //cuanta energia pierdo por el hecho de existir


  lado_izq = new FBox(5, 500);
  lado_izq.setPosition(50, 300);
  lado_izq.setStatic(true);


  caja_sup_izq = new FBox(100, 5);
  caja_sup_izq.setPosition(100, 50);
  caja_sup_izq.setStatic(true);


  lado_der = new FBox(5, 500);
  lado_der.setPosition(300, 300);
  lado_der.setStatic(true);


  caja_sup_der = new FBox(100, 5);
  caja_sup_der.setPosition(250, 50);
  caja_sup_der.setStatic(true);


  caja_inf_izq = new FBox(100, 5);
  caja_inf_izq.setPosition(100, 550);
  caja_inf_izq.setStatic(true);


  caja_inf_der = new FBox(100, 5);
  caja_inf_der.setPosition(250, 550);
  caja_inf_der.setStatic(true);


  mundo.add(lado_der);
  mundo.add(lado_izq);
  mundo.add(caja_sup_izq);
  mundo.add(caja_sup_der);
  mundo.add(caja_inf_izq);
  mundo.add(caja_inf_der);


  mundo.add(tejo);
}

void draw() {
  background(255);
  mundo.step();
  mundo.draw();

  punteroX = mouseX;
  punteroY = mouseY;
  xMap = map(tejo.getX(), 65, 290, -1, 1);
  yMap = map(tejo.getY(), 70, 540, 0.0015, 0.015);



  contadores.tiempo(60, 450, 50);
  contadores.marcador(goles, 500, 400);
  fondo.dibujar(50, 50, 250, 500);

  // println(tejo.getVelocityX());

  // OSC RECEPTOR

  //println(tejo.getX(), tejo.getY());
  receptor.actualizar(mensajes); //

  // receptor.dibujarBlobs(width, height);


  // Eventos de entrada y salida
  for (Blob b : receptor.blobs) {

    if (b.entro) {

      admin.crearPuntero(b);
      println("--> entro blob: " + b.id);
    }
    if (b.salio) {

      admin.removerPuntero(b);
      println("<-- salio blob: " + b.id);
    }
    admin.actualizarPuntero(b);
  }

  if (abs(tejo.getVelocityX())>5 || abs(tejo.getVelocityY())>5) {
    fx_noise.pan(xMap);
    fx_noise.amp(yMap*2);
    fx_noise.play();
    fx_noise2.amp(yMap);
    fx_noise2.pan(xMap);
    fx_noise2.play();
  } else {
    fx_noise2.stop();
    fx_noise.stop();
  }

  if (tejo.getY() < 36) {
    goles = goles +1;
    tejo.setPosition(174, 300);
    tejo.setVelocity(0, 0);
  }
  if (tejo.getY() > 565) {
    goles = goles -1;
    tejo.setPosition(174, 300);
    tejo.setVelocity(0, 0);
  }
  //println("cantidad de blobs: " + receptor.blobs.size());
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      goles = goles+1;
    } else if (keyCode == DOWN) {
      goles = goles-1;
    }
  }
  if (key == CODED) {
    if (keyCode == RIGHT) {
      tejo.setPosition(174, 300);
      tejo.setVelocity(0, 0);
    }
  }
}
void mousePressed() {
}
