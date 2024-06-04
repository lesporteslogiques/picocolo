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

String[] fichier_image = { 
  "cle_a_molette.png", 
  "pied_a_coulisse.png", 
  "pile.png",
  "pince_a_denuder.png",
  "pince_coupante.png",
  "pince_etau.png",
  "pince_universelle.png",
  "tournevis_cruciforme.png",
  "tournevis_plat.png"
};

PImage[] outil = new PImage[fichier_image.length];

/* ************************************* */

void setup() {
  size(874, 1240); // A5 paysage 150 dpi
  init();          // à conserver, utilisé pour la publication
  for (int i=0; i < fichier_image.length; i++){
    String fichier = fichier_image[i];
    outil[i] = loadImage(fichier);
  }
}

void draw() {
  
  // début de la partie graphique ***********************
  
  // Votre code commence ici!
  // pas de déroulement "infini" = inclure le code dans une boucle for, par exemple
  
  background(255);
  
  imageMode(CENTER);
  int index = (int)random(fichier_image.length);
  push();
  translate(width/2, height/2);
  
  float angle = 0;
  for (int i = 0; i < 24; i ++) {
    angle += 24; 
    float x = 600 * cos(radians(angle));
    float y = 600 * sin(radians(angle));
    push();
    translate(x,y);
    rotate(radians(i*24+15));
    image(outil[index], 0,0, outil[index].width/5,  outil[index].height/5);
    pop();
  }
  
  index = (index+1)%fichier_image.length;
  angle = 7;
  for (int i = 0; i < 40; i ++) {
    angle += 9; 
    float x = 500 * cos(radians(angle));
    float y = 500 * sin(radians(angle));
    push();
    translate(x,y);
    rotate(radians(i*20+15));
    image(outil[index], 0,0, outil[index].width/7,  outil[index].height/7);
    pop();
  }

  index = (index+1)%fichier_image.length;
  angle = 14;
  for (int i = 0; i < 18; i ++) {
    angle += 20; 
    float x = 350 * cos(radians(angle));
    float y = 350 * sin(radians(angle));
    push();
    translate(x,y);
    rotate(radians(i*20+15));
    image(outil[index], 0,0, outil[index].width/9,  outil[index].height/9);
    pop();
  }
  
  index = (index+1)%fichier_image.length;
  angle = 21;
  for (int i = 0; i < 12; i ++) {
    angle += 30; 
    float x = 200 * cos(radians(angle));
    float y = 200 * sin(radians(angle));
    push();
    translate(x,y);
    rotate(radians(i*30+15));
    image(outil[index], 0,0, outil[index].width/11,  outil[index].height/11);
    pop();
  }
  
  index = (index+1)%fichier_image.length;
  angle = 21;
  for (int i = 0; i < 40; i ++) {
    angle += 9; 
    float x = 50 * cos(radians(angle));
    float y = 50 * sin(radians(angle));
    push();
    translate(x,y);
    rotate(radians(i*9+15));
    image(outil[index], 0,0, outil[index].width/11,  outil[index].height/11);
    pop();
  }
  pop();

   
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
