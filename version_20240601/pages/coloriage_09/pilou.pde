/* "pilou" : Tracer une forme régulière avec poils au bout
 x, y : coordonnées de départ
 diam : diamètre maximum
 som : nombre de sommet
 a : angle de départ
 */
void pilou(float x, float y, float diam, int som, float a) {

  // Les points qui composent la forme sont enregistrés dans un tableau à 2 dimensions
  float[][] coord = new float[som][2];

  float d;
  float l;
  // D'abord calculer les points
  for (int i = 0; i < som; i++) {
    float angle = a + (360 / (float)som) * (float)i;
    if (i%2 == 0) d = diam * 0.4;
    else d = diam * random(0.95, 1.05);
    float xsom = x + d * cos(radians(angle));
    float ysom = y + d * sin(radians(angle));
    coord[i][0] = xsom;
    coord[i][1] = ysom;
    if (i%2 == 1) {
      l = random(1.05, 1.2);
      float m = random(0.95, 1.05);
      float xsom2 = x + (d*l*m) * cos(radians(angle));
      float ysom2 = y + (d*l*m) * sin(radians(angle));
      line(xsom, ysom, xsom2, ysom2);
      float xsom3 = x + (d*l*m) * cos(radians(angle)-0.06);
      float ysom3 = y + (d*l*m) * sin(radians(angle)-0.06);
      line(xsom, ysom, xsom3, ysom3);
      float xsom4 = x + (d*l*m) * cos(radians(angle)+0.06);
      float ysom4 = y + (d*l*m) * sin(radians(angle)+0.06);
      line(xsom, ysom, xsom4, ysom4);
    }
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
}
