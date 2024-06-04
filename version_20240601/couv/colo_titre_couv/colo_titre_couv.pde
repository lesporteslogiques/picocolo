/*
  Squelette de code pour créer une illustration au format A5, portrait à 150 dpi
  Cours code créatif / EDNA, novembre 2019 / pierre@lesporteslogiques.net
  'espace' pour redessiner une image
  's' pour enregistrer l'image de la fenêtre au format png
 */

String emplacement = ""; // à conserver tel quel, utilisé pour la publication
boolean TESTMODE = true; // à conserver tel quel, utilisé pour la publication

import java.util.Date;
import java.text.SimpleDateFormat;
String SKETCH_NAME = getClass().getSimpleName();

/* ****** variables du sketch ********** */

String fichier =  "colo_titre_couv.png"; 

// 2 paramètres vont modifier l'image
int tranches_orig_h = 16;    // nombre de tranches toujours un multiple de 2
int tranches_orig_v = 32;    // nombre de tranches toujours un multiple de 2
float variation_h = -0.35;     // variation pour chaque tranche, entre -0.5 et 0.5
float variation_v = 0.35;     // variation pour chaque tranche

// Dimensions du buffer, l'image affichée est réduite à la taille de la fenêtre
// mais l'image enregistrée n'a pas nécessairement ces dimensions
int largeur_dest = 874;
int hauteur_dest = 1240;

PImage image_orig;
PGraphics image_dest;
PImage image_tr;
PGraphics image_dest2;

int tranches_dest_h = tranches_orig_h;
int tranches_dest_v = tranches_orig_v;

// Variables utilisées pour les calculs de chaque tranche
float[] v1 = {1};
float[] v2;


/* ************************************* */


void setup() {
  size(874, 1240); // A5 paysage 150 dpi
  init();          // à conserver, utilisé pour la publication
  image_orig = loadImage("titre.png");
  image_tr = createImage(largeur_dest, hauteur_dest, RGB);
  image_dest = createGraphics(largeur_dest, hauteur_dest);
  image_dest2 = createGraphics(largeur_dest, hauteur_dest);
}

void draw() {
  
  // début de la partie graphique ***********************
  
  // Votre code commence ici!
  
  background(255);
  stroke(0);
int starty = 0;

  // for (int iter = 0; iter < 16; iter ++) {
  //tranches_dest = tranches_orig;
  // Calculer les valeurs pour chaque tranche
  while (tranches_dest_h >= 2) {
    println(tranches_dest_h);
    v2 = doubler(v1, variation_h);
    println(v2);
    if (tranches_dest_h > 2) {
      v1 = new float[v1.length * 2];
      arrayCopy(v2, v1);
      v2 = new float[v2.length * 2];
    }
    tranches_dest_h /= 2;
  }

  // Afficher avec ces valeurs
  float pixw = 0;
  image_dest.beginDraw();

  for (int i = 0; i < v2.length; i++) {
    int sx = int( i * (image_orig.width / tranches_orig_h) );
    int sy = 0;
    int sw = int( image_orig.width / tranches_orig_h );
    int sh = image_orig.height;
    int dx = int( pixw );
    int dy = 0 + starty;
    int dw = int( image_dest.width * v2[i] );
    int dh = image_dest.height;
    /*
     sx(int) X coordinate of the source's upper left corner
     sy(int) Y coordinate of the source's upper left corner
     sw(int) source image width
     sh(int) source image height
     dx(int) X coordinate of the destination's upper left corner
     dy(int) Y coordinate of the destination's upper left corner
     dw(int) destination image width
     dh(int) destination image height
     src(PImage) an image variable referring to the source image.
    */
    image_dest.copy(image_orig, sx, sy, sw, sh, dx, dy, dw, dh);
    pixw += dw;
    println("bloucing "+sx+" "+sy+" "+sw+" "+sh+" / "+dx+" "+dy+" "+dw+" "+dh+" / "+pixw);
  }

  image_dest.endDraw();

  image_tr = image_dest.get();

  // Remettre à zéro les valeurs de chaque tranche
  v1 = new float[1];
  v1[0] = 1;
  v2 = new float[2];

  while (tranches_dest_v >= 2) {
    println(tranches_dest_v);
    v2 = doubler(v1, variation_v);
    println(v2);
    if (tranches_dest_v > 2) {
      v1 = new float[v1.length * 2];
      arrayCopy(v2, v1);
      v2 = new float[v2.length * 2];
    }
    tranches_dest_v /= 2;
  }

  image_dest2.beginDraw();
  float pixh = 0;

  for (int i = 0; i < v2.length; i++) {
    int sx = 0;
    int sy = int( i * (image_dest.height / tranches_orig_v) );
    int sw = image_dest.width;
    int sh = int( image_dest.height / tranches_orig_v ); 
    int dx = 0;
    int dy = int( pixh );
    int dw = image_dest.width; 
    int dh = int( image_dest.height * v2[i] );
    image_dest2.copy(image_tr, sx, sy, sw, sh, dx, dy, dw, dh);
    pixh += dh;
    println("bloucing "+sx+" "+sy+" "+sw+" "+sh+" / "+dx+" "+dy+" "+dw+" "+dh+" / "+pixw);
  }
  image_dest2.endDraw();

  image(image_dest2, 50, 150, 700, 700);
   
  // Votre code s'arrête ici!
  
  marges(); // ajout des marges, 4mm de blanc tout autour
  // fin de la partie graphique *************************  
  
  if (!TESTMODE) {
    saveFrame(emplacement + fichier);
    exit();
  }
  noLoop();
}

/**
 * Prendre un tableau de valeurs et retourner un tableau du double des valeurs
 * 
 * @param valeurs    tableau des valeurs à traiter
 * @param variation  une valeur entre 0 et 100%
 */
public float[] doubler(float[] valeurs, float variation) {
  int taille = valeurs.length * 2;
  int index = 0;
  float[] valeurs_new = new float[taille];
  for (float v : valeurs) {
    float varia = random(100) / 100 * variation + 0.5;
    valeurs_new[index] = v * varia;
    valeurs_new[index+1] = v * (1 - varia);
    index += 2;
  }
  return valeurs_new;
}

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
  rect(0, 0, width, 24);         // haut
  rect(0, height-24, width, 24); // bas
  rect(0, 0, 24, height);        // gauche
  rect(width-24, 0, 24, height); // droite
}
