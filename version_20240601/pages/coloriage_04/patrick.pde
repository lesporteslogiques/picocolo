/* "patrick" : Tracer une sorte d'étoile avec des lignes
   x, y : coordonnées de départ
   diam : diamètre maximum
   som : nombre de sommet
   a : angle de départ
*/
void patrick(float x, float y, float diam, int som, float a) {

  // Les points qui composent la forme sont enregistrés dans un tableau à 2 dimensions
  float[][] coord = new float[som][2];
  
  // D'abord calculer les points
  for (int i = 0; i < som; i++) {
    float angle = a + (360 / (float)som) * (float)i;
    float diamod = random(0.7, 1.0);
    float xsom = x + (diam*diamod) * cos(radians(angle));
    float ysom = y + (diam*diamod) * sin(radians(angle));
    coord[i][0] = xsom;
    coord[i][1] = ysom;
    float xsom2 = x + (diam*diamod*2) * cos(radians(angle));
    float ysom2 = y + (diam*diamod*2) * sin(radians(angle));
    line(xsom, ysom, xsom2, ysom2);
    if (random(100) > 20) ellipse(xsom2, ysom2, 4, 4);
  }
  
  // Puis tracer la forme
  beginShape();
  for (int i = 0; i < som; i++) {
    if (i == 0) curveVertex(coord[som-1][0], coord[som-1][1]);
    curveVertex(coord[i][0], coord[i][1]);
    if (i == som-1) {
      curveVertex(coord[0][0], coord[0][1]);
      curveVertex(coord[1][0], coord[1][1]);
    }
  }
  endShape(CLOSE);
  /*
  // Et les petits points
  float step = random(4, 24);
  float maxangle = 360 * random(3, 8);
  float d = diam * 0.9;
  for (float i = 720; i < maxangle; i+= step) {
    float xsom = x + (d * (i/maxangle)) * cos(radians(i + a));
    float ysom = y + (d * (i/maxangle)) * sin(radians(i + a));
    ellipse(xsom, ysom, 1, 1);
  }*/
}
