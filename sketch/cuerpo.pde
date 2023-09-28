FCircle crearTejo( float t, float g) {

  FCircle main = new FCircle(t);
  main.setPosition(174, 300);
 // main.setVelocity(0, 0);
  main.setNoStroke();
  main.setFill(0, 255, 0);
  main.setDamping(0.4);
  main.setGrabbable(true);
  return main;
}
