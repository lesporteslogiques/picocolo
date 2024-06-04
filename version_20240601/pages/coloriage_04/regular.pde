/* "regular" : Tracer une forme régulière
   x, y : coordonnées de départ
   diam : diamètre maximum
   som : nombre de sommet
   a : angle de départ
*/
void regular(float x, float y, float diam, int som, float a) {

  // Les points qui composent la forme sont enregistrés dans un tableau à 2 dimensions
  float[][] coord = new float[som][2];
  
  float d;
  
  // D'abord calculer les points
  for (int i = 0; i < som; i++) {
    float angle = a + (360 / (float)som) * (float)i;
    if (i%2 == 0) d = diam * 0.5;
    else d = diam;
    float xsom = x + d * cos(radians(angle));
    float ysom = y + d * sin(radians(angle));
    coord[i][0] = xsom;
    coord[i][1] = ysom;
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
