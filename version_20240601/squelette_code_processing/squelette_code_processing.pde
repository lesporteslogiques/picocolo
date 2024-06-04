/*
  Squelette de code pour créer une illustration au format A5, portrait à 150 dpi
  Cahier de coloriage des portes logiques / mai 2024 / pierre@lesporteslogiques.net

  'espace' pour redessiner une image
  's' pour enregistrer l'image de la fenêtre au format png
 */

String emplacement = ""; // à conserver tel quel, utilisé pour la publication
boolean TESTMODE = true; // à conserver tel quel, utilisé pour la publication

import java.util.Date;
import java.text.SimpleDateFormat;
String SKETCH_NAME = getClass().getSimpleName();
String fichier =  "squelette_code_processing.png";

/* ****** variables du sketch ********** */

/* ************************************* */

void setup() {
  size(874, 1240); // A5 paysage 150 dpi
  init();          // à conserver, utilisé pour la publication
}

void draw() {
  
  // début de la partie graphique ***********************
  
  // Votre code commence ici!
  // pas de déroulement "infini" = inclure le code dans une boucle for, par exemple

  ellipse (width / 2, height / 2, 100, 100);  // test
   
  // Votre code s'arrête ici!
  
  marges(); // ajout des marges, 4mm de blanc tout autour
  // fin de la partie graphique *************************  
  
  if (!TESTMODE) {
    saveFrame(emplacement + fichier);
    exit();
  }
  noLoop();
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
  rect(0, 0, width, 24);         // haut
  rect(0, height-24, width, 24); // bas
  rect(0, 0, 24, height);        // gauche
  rect(width-24, 0, 24, height); // droite
}
