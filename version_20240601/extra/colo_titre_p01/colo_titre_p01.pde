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

String fichier =  "colo_titre_p01.png"; 

PImage image_orig;
PFont picnic;


/* ************************************* */


void setup() {
  size(874, 1240); // A5 paysage 150 dpi
  init();          // à conserver, utilisé pour la publication
  image_orig = loadImage("/home/emoc/ZINES/picocolo/couv_1.png");
  picnic = loadFont("PicNic-Regular-96.vlw");
}

void draw() {
  
  // début de la partie graphique ***********************
  
  // Votre code commence ici!
  
  background(255);
  stroke(0);
  fill(0);


  image(image_orig, 0, 0);
  textFont(picnic, 36);
  text("ce carnet appartient à", 200, height - 200);
  text("  . . . . . . . . . . . . . . . ", 200, height - 100);
   
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
