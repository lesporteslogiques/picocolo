/*
  Squelette de code pour créer une illustration au format A5, portrait à 150 dpi
  Cahier de coloriage des portes logiques / mai 2024 / pierre@lesporteslogiques.net

  'espace' pour redessiner une image
  's' pour enregistrer l'image de la fenêtre au format png
 */

String emplacement = ""; // à conserver tel quel, utilisé pour la publication
boolean TESTMODE = false; // à conserver tel quel, utilisé pour la publication

import java.util.Date;
import java.text.SimpleDateFormat;
String SKETCH_NAME = getClass().getSimpleName();
String fichier =  "squelette_code_processing.png";

/* ****** variables du sketch ********** */

/* ************************************* */

void setup() {
  size(874, 1240, P3D); // A5 paysage 150 dpi
  hint(DISABLE_DEPTH_TEST); // Pour que les marges s'affichent au dessus en mode P3D
  hint(DISABLE_OPTIMIZED_STROKE); // idem (j'ai cherché un bon moment pour le trouver !)
  hint(ENABLE_STROKE_PERSPECTIVE);
  init();          // à conserver, utilisé pour la publication
}


int opacity = 200; // J'aime pas le noir total :p

void draw() {
  // début de la partie graphique ***********************
  
  // Votre code commence ici!
  // pas de déroulement "infini" = inclure le code dans une boucle for, par exemple
  background(255);
  
  pushMatrix();
  translate(width/2, height/2, random(100, 400));
  rotateX(random(0, 0.8));
  rotateY(random(-0.8, 0.8));
  
  int n_circles = floor(random(40, 64));
  int n_points = 32;
  float circle_step = random(6, 10);
  float noiseStrength = random(4.0, 6.0);
  for (int c = 0; c < n_circles; c++) {
    PVector[] path = new PVector[n_points];
    float angle = 0.0;
    float diam = 10 + circle_step*c;
    for (int i = 0; i < n_points; i++) {
      angle = i * (TWO_PI/n_points);
      float x = diam * cos(angle);
      x = x + (noise(diam*0.1 + random(999), i*2 + 919234)-0.5) * (noiseStrength+c/3);
      float y = diam * sin(angle);
      y = y + (noise(diam*0.1  + random(999), i*2 + 14923)-0.5) * (noiseStrength+c/3);
      float z = noise(x/10, y/10) * diam*diam/400;
      path[i] = new PVector(x, y, z);
    }
    pathCurve(path, c);
  }
  popMatrix();
  // Votre code s'arrête ici!
  
  marges(); // ajout des marges, 4mm de blanc tout autour
  // fin de la partie graphique *************************  
  
  if (!TESTMODE) {
    saveFrame(emplacement + fichier);
    exit();
  }
  noLoop();
}


int bold_mod = floor(random(3, 9));

void pathCurve(PVector[] path, int c) {
  //curveTightness(1.0);
  if (c == 0) {
    fill(0, opacity);
    noStroke();
  } else if (c % bold_mod == 0) {
    noFill();
    stroke(0, opacity);
    strokeWeight(3);
  } else {
    noFill();
    stroke(0, opacity);
    strokeWeight(1);
  }
  beginShape();
  int last_idx = path.length-1;
  curveVertex(path[last_idx].x, path[last_idx].y, path[last_idx].z);  // start anchor point
  int i;
  for (i=0; i<path.length; i++) {
    curveVertex(path[i].x, path[i].y, path[i].z);
  }
  curveVertex(path[0].x, path[0].y, path[0].z);
  curveVertex(path[1].x, path[1].y, path[1].z);  // end anchor point
  endShape();
}


// Interaction clavier

void keyPressed() {
  if (key == ' ') redraw();
  if (key == 's') {
    Date aujourdhui = new Date();
    SimpleDateFormat formater = new SimpleDateFormat("yyyyMMdd_HHmmss");
    System.out.println(formater.format(aujourdhui));
    saveFrame(SKETCH_NAME + "_" + formater.format(aujourdhui) + ".png");
  }
}



// Fonction utilisée pour la publication à conserver telle quelle

void init() {
  if (args != null) {
    println(args.length);
    for (int i = 0; i < args.length; i++) {
      println(args[i]);
    }
    fichier = args[0];
    emplacement = args[1];
    if (args[2].equals("0")) TESTMODE = false;
    else TESTMODE = true;
    println("fichier : " + fichier);
    println("emplacement : " + emplacement);
    println("testmode : " + TESTMODE);
    println(fichier + " en cours");
  } else {
    println("args == null");
  }
}

// Fonction pour ajouter des marges ******************************

void marges() {
  colorMode(RGB);
  fill(255);
  stroke(255);
  strokeWeight(1.0);
  rect(0, 0, width, 24);         // haut
  rect(0, height-24, width, 24); // bas
  rect(0, 0, 24, height);        // gauche
  rect(width-24, 0, 24, height); // droite
}
